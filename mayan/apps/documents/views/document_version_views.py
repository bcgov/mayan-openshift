import logging

from django.contrib import messages
from django.template import RequestContext
from django.urls import reverse
from django.utils.translation import ugettext_lazy as _, ungettext

from mayan.apps.converter.layers import layer_saved_transformations
from mayan.apps.converter.permissions import (
    permission_transformation_delete, permission_transformation_edit
)
from mayan.apps.file_caching.tasks import task_cache_partition_purge
from mayan.apps.views.generics import (
    FormView, MultipleObjectConfirmActionView, MultipleObjectDeleteView,
    SingleObjectCreateView, SingleObjectDetailView,
    SingleObjectEditView, SingleObjectListView
)
from mayan.apps.views.mixins import ExternalObjectMixin

from ..events import event_document_viewed
from ..forms.document_version_forms import (
    DocumentVersionForm, DocumentVersionPreviewForm
)
from ..forms.misc_forms import PageNumberForm
from ..icons import icon_document_version_list
from ..links.document_version_links import link_document_version_create
from ..models.document_models import Document
from ..models.document_version_models import DocumentVersion
from ..permissions import (
    permission_document_version_create, permission_document_version_delete,
    permission_document_version_edit, permission_document_version_export,
    permission_document_version_print, permission_document_version_view
)
from ..tasks import task_document_version_export

from .misc_views import PrintFormView, DocumentPrintView

__all__ = (
    'DocumentVersionCreateView', 'DocumentVersionListView',
    'DocumentVersionPreviewView'
)
logger = logging.getLogger(name=__name__)


class DocumentVersionCachePartitionPurgeView(MultipleObjectConfirmActionView):
    model = DocumentVersion
    #object_permission = permission_cache_purge
    pk_url_kwarg = 'document_version_id'
    success_message_singular = '%(count)d document version submitted for cache purging.'
    success_message_plural = '%(count)d document versions submitted for cache purging.'

    def get_extra_context(self):
        result = {
            'title': ungettext(
                singular='Submit the selected document version for cache purging?',
                plural='Submit the selected document versions for cache purging?',
                number=self.object_list.count()
            )
        }

        if self.object_list.count() == 1:
            result['object'] = self.object_list.first()

        return result

    def object_action(self, form, instance):
        task_cache_partition_purge.apply_async(
            kwargs={
                'cache_partition_id': instance.cache_partition.pk,
                #'user_id': self.request.user.pk
            }
        )
        for page in instance.pages.all():
            task_cache_partition_purge.apply_async(
                kwargs={
                    'cache_partition_id': page.cache_partition.pk,
                    #'user_id': self.request.user.pk
                }
            )


class DocumentVersionCreateView(ExternalObjectMixin, SingleObjectCreateView):
    external_object_class = Document
    external_object_permission = permission_document_version_create
    external_object_pk_url_kwarg = 'document_id'
    form_class = DocumentVersionForm

    def get_extra_context(self):
        return {
            'object': self.external_object,
            'title': _(
                'Create a document version for document: %s'
            ) % self.external_object,
        }

    def get_instance_extra_data(self):
        return {
            '_event_actor': self.request.user,
            'document': self.external_object
        }

    def get_queryset(self):
        return self.external_object.versions.all()


class DocumentVersionDeleteView(MultipleObjectDeleteView):
    model = DocumentVersion
    object_permission = permission_document_version_delete
    pk_url_kwarg = 'document_version_id'

    def get_instance_extra_data(self):
        return {
            '_event_actor': self.request.user,
        }

    def get_post_action_redirect(self):
        # Use [0] instead of first(). First returns None and it is not usable.
        return reverse(
            viewname='documents:document_version_list', kwargs={
                'document_id': self.object_list[0].document_id
            }
        )


class DocumentVersionEditView(SingleObjectEditView):
    form_class = DocumentVersionForm
    model = DocumentVersion
    object_permission = permission_document_version_edit
    pk_url_kwarg = 'document_version_id'

    def get_extra_context(self):
        return {
            'title': _('Edit document version: %s') % self.object,
        }

    def get_instance_extra_data(self):
        return {
            '_event_actor': self.request.user,
        }

    def get_post_action_redirect(self):
        return reverse(
            viewname='documents:document_version_preview', kwargs={
                'document_version_id': self.object.pk
            }
        )


class DocumentVersionExportView(MultipleObjectConfirmActionView):
    model = DocumentVersion
    object_permission = permission_document_version_export
    pk_url_kwarg = 'document_version_id'
    success_message = _(
        '%(count)d document version queued for export.'
    )
    success_message_plural = _(
        '%(count)d document versions queued for export.'
    )

    def get_extra_context(self):
        context = {
            'message': _(
                'The process will be performed in the background. '
                'The exported file will be available in the downloads area.'
            ),
            'title': ungettext(
                singular='Export the selected document version?',
                plural='Export the selected document versions?',
                number=self.object_list.count()
            )
        }

        if self.object_list.count() == 1:
            context['object'] = self.object_list.first()

        return context

    def object_action(self, form, instance):
        task_document_version_export.apply_async(
            kwargs={'document_version_id': instance.pk}
        )


class DocumentVersionListView(ExternalObjectMixin, SingleObjectListView):
    external_object_class = Document
    external_object_permission = permission_document_version_view
    external_object_pk_url_kwarg = 'document_id'

    def get_document(self):
        document = self.external_object
        document.add_as_recent_document_for_user(user=self.request.user)
        return document

    def get_extra_context(self):
        return {
            'hide_object': True,
            'list_as_items': True,
            'no_results_icon': icon_document_version_list,
            'no_results_main_link': link_document_version_create.resolve(
                context=RequestContext(request=self.request)
            ),
            'no_results_text': _(
                'Versions are views that can display document file pages as '
                'they are, remap or merge them into different layouts.'
            ),
            'no_results_title': _('No versions available'),
            'object': self.get_document(),
            'table_cell_container_classes': 'td-container-thumbnail',
            'title': _('Versions of document: %s') % self.get_document(),
        }

    def get_source_queryset(self):
        return self.get_document().versions.order_by('-timestamp')


class DocumentVersionPreviewView(SingleObjectDetailView):
    form_class = DocumentVersionPreviewForm
    model = DocumentVersion
    object_permission = permission_document_version_view
    pk_url_kwarg = 'document_version_id'

    def dispatch(self, request, *args, **kwargs):
        result = super().dispatch(request, *args, **kwargs)
        self.object.document.add_as_recent_document_for_user(
            user=request.user
        )
        event_document_viewed.commit(
            actor=request.user, action_object=self.object,
            target=self.object.document
        )

        return result

    def get_extra_context(self):
        return {
            'hide_labels': True,
            'object': self.object,
            'title': _('Preview of document version: %s') % self.object,
        }


class DocumentVersionPrintFormView(PrintFormView):
    external_object_class = DocumentVersion
    external_object_permission = permission_document_version_print
    external_object_pk_url_kwarg = 'document_version_id'
    print_view_name = 'documents:document_version_print_view'
    print_view_kwarg = 'document_version_id'

    def _add_recent_document(self):
        self.external_object.document.add_as_recent_document_for_user(
            user=self.request.user
        )


class DocumentVersionPrintView(DocumentPrintView):
    external_object_class = DocumentVersion
    external_object_permission = permission_document_version_print
    external_object_pk_url_kwarg = 'document_version_id'

    def _add_recent_document(self):
        self.external_object.document.add_as_recent_document_for_user(
            user=self.request.user
        )


class DocumentVersionTransformationsClearView(MultipleObjectConfirmActionView):
    model = DocumentVersion
    object_permission = permission_transformation_delete
    pk_url_kwarg = 'document_version_id'
    success_message = _(
        'Transformation clear request processed for %(count)d document version.'
    )
    success_message_plural = _(
        'Transformation clear request processed for %(count)d document versions.'
    )

    def get_extra_context(self):
        result = {
            'title': ungettext(
                singular='Clear all the page transformations for the selected document version?',
                plural='Clear all the page transformations for the selected document version?',
                number=self.object_list.count()
            )
        }

        if self.object_list.count() == 1:
            result.update(
                {
                    'object': self.object_list.first(),
                    'title': _(
                        'Clear all the page transformations for the '
                        'document version: %s?'
                    ) % self.object_list.first()
                }
            )

        return result

    def object_action(self, form, instance):
        try:
            for page in instance.pages.all():
                layer_saved_transformations.get_transformations_for(
                    obj=page
                ).delete()
        except Exception as exception:
            messages.error(
                message=_(
                    'Error deleting the page transformations for '
                    'document_version: %(document_version)s; %(error)s.'
                ) % {
                    'document_version': instance, 'error': exception
                }, request=self.request
            )


class DocumentVersionTransformationsCloneView(ExternalObjectMixin, FormView):
    external_object_class = DocumentVersion
    external_object_permission = permission_transformation_edit
    external_object_pk_url_kwarg = 'document_version_id'
    form_class = PageNumberForm

    def dispatch(self, request, *args, **kwargs):
        results = super().dispatch(request=request, *args, **kwargs)
        self.external_object.document.add_as_recent_document_for_user(
            user=request.user
        )

        return results

    def form_valid(self, form):
        try:
            layer_saved_transformations.copy_transformations(
                delete_existing=True, source=form.cleaned_data['page'],
                targets=form.cleaned_data['page'].siblings.exclude(
                    pk=form.cleaned_data['page'].pk
                )
            )
        except Exception as exception:
            if settings.DEBUG:
                raise
            else:
                messages.error(
                    message=_(
                        'Error cloning the page transformations for '
                        'document version: %(document_version)s; %(error)s.'
                    ) % {
                        'document_version': self.external_object,
                        'error': exception
                    }, request=self.request
                )
        else:
            messages.success(
                message=_('Transformations cloned successfully.'),
                request=self.request
            )

        return super().form_valid(form=form)

    def get_form_extra_kwargs(self):
        return {
            'instance': self.external_object
        }

    def get_extra_context(self):
        context = {
            'object': self.external_object,
            'submit_label': _('Submit'),
            'title': _(
                'Clone page transformations of document version: %s'
            ) % self.external_object,
        }

        return context
