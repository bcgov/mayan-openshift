from django.conf import settings
from django.contrib.contenttypes.fields import GenericForeignKey
from django.contrib.contenttypes.models import ContentType
from django.db import models
from django.utils.translation import ugettext_lazy as _

from actstream.models import Action

from .managers import (
    EventSubscriptionManager, NotificationManager,
    ObjectEventSubscriptionManager
)
from .model_mixins import (
    NotificationBusinessLogicMixin, StoredEventTypeBusinessLogicMixin
)


class StoredEventType(StoredEventTypeBusinessLogicMixin, models.Model):
    """
    Model to mirror the real event classes as database objects.
    """
    name = models.CharField(
        max_length=64, unique=True, verbose_name=_('Name')
    )

    class Meta:
        verbose_name = _('Stored event type')
        verbose_name_plural = _('Stored event types')

    def __str__(self):
        return str(self.label)


class EventSubscription(models.Model):
    """
    This model stores the event subscriptions of a user for the entire
    system.
    """
    user = models.ForeignKey(
        db_index=True, on_delete=models.CASCADE,
        related_name='event_subscriptions', to=settings.AUTH_USER_MODEL,
        verbose_name=_('User')
    )
    stored_event_type = models.ForeignKey(
        on_delete=models.CASCADE, related_name='event_subscriptions',
        to=StoredEventType, verbose_name=_('Event type')
    )

    objects = EventSubscriptionManager()

    class Meta:
        verbose_name = _('Event subscription')
        verbose_name_plural = _('Event subscriptions')

    def __str__(self):
        return str(self.stored_event_type)


class Notification(NotificationBusinessLogicMixin, models.Model):
    """
    This model keeps track of the notifications for a user. Notifications are
    created when an event to which this user has been subscribed, are
    committed elsewhere in the system.
    """
    user = models.ForeignKey(
        db_index=True, on_delete=models.CASCADE,
        related_name='notifications', to=settings.AUTH_USER_MODEL,
        verbose_name=_('User')
    )
    action = models.ForeignKey(
        on_delete=models.CASCADE, related_name='notifications', to=Action,
        verbose_name=_('Action')
    )
    read = models.BooleanField(
        default=False, verbose_name=_('Read')
    )

    objects = NotificationManager()

    class Meta:
        ordering = ('-action__timestamp',)
        verbose_name = _('Notification')
        verbose_name_plural = _('Notifications')

    def __str__(self):
        return str(self.action)


class ObjectEventSubscription(models.Model):
    content_type = models.ForeignKey(
        on_delete=models.CASCADE, to=ContentType,
    )
    object_id = models.PositiveIntegerField()
    content_object = GenericForeignKey(
        ct_field='content_type',
        fk_field='object_id',
    )
    user = models.ForeignKey(
        db_index=True, on_delete=models.CASCADE,
        related_name='object_subscriptions', to=settings.AUTH_USER_MODEL,
        verbose_name=_('User')
    )
    stored_event_type = models.ForeignKey(
        on_delete=models.CASCADE, related_name='object_subscriptions',
        to=StoredEventType, verbose_name=_('Event type')
    )

    objects = ObjectEventSubscriptionManager()

    class Meta:
        ordering = ('pk',)
        verbose_name = _('Object event subscription')
        verbose_name_plural = _('Object event subscriptions')

    def __str__(self):
        return str(self.stored_event_type)
