from django.contrib import messages
from django.shortcuts import get_object_or_404
from django.template import RequestContext
from django.urls import reverse_lazy
from django.utils.translation import gettext_lazy as _

from mayan.apps.views.generics import ConfirmView, SingleObjectListView

from ..icons import (
    icon_notification_list, icon_notification_mark_read,
    icon_notification_mark_read_all
)
from ..links import link_event_type_subscription_list

from .view_mixins import NotificationViewMixin


class NotificationListView(NotificationViewMixin, SingleObjectListView):
    view_icon = icon_notification_list

    def get_extra_context(self):
        return {
            'hide_object': True,
            'no_results_icon': icon_notification_list,
            'no_results_main_link': link_event_type_subscription_list.resolve(
                context=RequestContext(request=self.request)
            ),
            'no_results_text': _(
                message='Subscribe to global or object events to receive '
                'notifications.'
            ),
            'no_results_title': _(message='There are no notifications'),
            'title': _(message='Notifications')
        }


class NotificationMarkRead(NotificationViewMixin, ConfirmView):
    post_action_redirect = reverse_lazy(
        viewname='events:user_notifications_list'
    )
    view_icon = icon_notification_mark_read

    def get_extra_context(self):
        return {
            'title': _(message='Mark the selected notification as read?')
        }

    def get_object(self):
        return get_object_or_404(
            klass=self.get_source_queryset(),
            pk=self.kwargs['notification_id']
        )

    def view_action(self, form=None):
        obj = self.get_object()
        obj.read = True
        obj.save()

        messages.success(
            message=_(message='Notification marked as read.'), request=self.request
        )


class NotificationMarkReadAll(NotificationViewMixin, ConfirmView):
    post_action_redirect = reverse_lazy(
        viewname='events:user_notifications_list'
    )
    view_icon = icon_notification_mark_read_all

    def get_extra_context(self):
        return {
            'title': _(message='Mark all notification as read?')
        }

    def view_action(self, form=None):
        self.get_source_queryset().update(read=True)

        messages.success(
            message=_(message='All notifications marked as read.'),
            request=self.request
        )
