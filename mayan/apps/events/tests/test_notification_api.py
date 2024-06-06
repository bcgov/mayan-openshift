from rest_framework import status

from mayan.apps.authentication.events import event_user_logged_out
from mayan.apps.rest_api.tests.base import BaseAPITestCase

from .mixins import (
    EventObjectTestMixin, EventTypeTestMixin, NotificationAPIViewTestMixin
)


class NotificationAPIViewTestCase(
    EventObjectTestMixin, EventTypeTestMixin, NotificationAPIViewTestMixin,
    BaseAPITestCase
):
    def setUp(self):
        super().setUp()
        self._create_test_event_type()
        self._create_test_object_with_event_type_and_permission()
        self._create_test_event(target=self._test_object)
        self._create_test_notification()

    def test_tag_detail_anonymous_api_view(self):
        self.logout()

        response = self._request_test_notification_detail_api_view()
        self.assertEqual(response.status_code, status.HTTP_404_NOT_FOUND)

        events = self._get_test_events()
        self.assertEqual(events.count(), 2)

        self.assertEqual(events[0].action_object, None)
        self.assertEqual(events[0].actor, self._test_case_user)
        self.assertEqual(events[0].target, self._test_object)
        self.assertEqual(events[0].verb, self._test_event_type.id)

        self.assertEqual(events[1].action_object, None)
        self.assertEqual(events[1].actor, self._test_case_user)
        self.assertEqual(events[1].target, self._test_case_user)
        self.assertEqual(events[1].verb, event_user_logged_out.id)

    def test_tag_detail_api_view(self):
        response = self._request_test_notification_detail_api_view()
        self.assertEqual(response.status_code, status.HTTP_200_OK)

        self.assertEqual(
            response.data['action']['target_object_id'],
            str(self._test_object.pk)
        )

        events = self._get_test_events()
        self.assertEqual(events.count(), 1)

        self.assertEqual(events[0].action_object, None)
        self.assertEqual(events[0].actor, self._test_case_user)
        self.assertEqual(events[0].target, self._test_object)
        self.assertEqual(events[0].verb, self._test_event_type.id)

    def test_tag_edit_anonymous_api_via_patch_view(self):
        self.logout()

        _test_notification_read = self._test_notification.read

        response = self._request_test_notification_edit_api_view(verb='patch')
        self.assertEqual(response.status_code, status.HTTP_404_NOT_FOUND)

        self._test_notification.refresh_from_db()

        self.assertEqual(
            self._test_notification.read,
            _test_notification_read
        )

        events = self._get_test_events()
        self.assertEqual(events.count(), 2)

        self.assertEqual(events[0].action_object, None)
        self.assertEqual(events[0].actor, self._test_case_user)
        self.assertEqual(events[0].target, self._test_object)
        self.assertEqual(events[0].verb, self._test_event_type.id)

        self.assertEqual(events[1].action_object, None)
        self.assertEqual(events[1].actor, self._test_case_user)
        self.assertEqual(events[1].target, self._test_case_user)
        self.assertEqual(events[1].verb, event_user_logged_out.id)

    def test_tag_edit_api_via_patch_view(self):
        _test_notification_read = self._test_notification.read

        response = self._request_test_notification_edit_api_view(verb='patch')
        self.assertEqual(response.status_code, status.HTTP_200_OK)

        self._test_notification.refresh_from_db()

        self.assertNotEqual(
            self._test_notification.read,
            _test_notification_read
        )

        events = self._get_test_events()
        self.assertEqual(events.count(), 1)

        self.assertEqual(events[0].action_object, None)
        self.assertEqual(events[0].actor, self._test_case_user)
        self.assertEqual(events[0].target, self._test_object)
        self.assertEqual(events[0].verb, self._test_event_type.id)

    def test_tag_edit_anonymous_api_via_put_view(self):
        self.logout()

        _test_notification_read = self._test_notification.read

        response = self._request_test_notification_edit_api_view(verb='put')
        self.assertEqual(response.status_code, status.HTTP_404_NOT_FOUND)

        self._test_notification.refresh_from_db()

        self.assertEqual(
            self._test_notification.read,
            _test_notification_read
        )

        events = self._get_test_events()
        self.assertEqual(events.count(), 2)

        self.assertEqual(events[0].action_object, None)
        self.assertEqual(events[0].actor, self._test_case_user)
        self.assertEqual(events[0].target, self._test_object)
        self.assertEqual(events[0].verb, self._test_event_type.id)

        self.assertEqual(events[1].action_object, None)
        self.assertEqual(events[1].actor, self._test_case_user)
        self.assertEqual(events[1].target, self._test_case_user)
        self.assertEqual(events[1].verb, event_user_logged_out.id)

    def test_tag_edit_api_via_put_view(self):
        _test_notification_read = self._test_notification.read

        response = self._request_test_notification_edit_api_view(verb='put')
        self.assertEqual(response.status_code, status.HTTP_200_OK)

        self._test_notification.refresh_from_db()

        self.assertNotEqual(
            self._test_notification.read,
            _test_notification_read
        )

        events = self._get_test_events()
        self.assertEqual(events.count(), 1)

        self.assertEqual(events[0].action_object, None)
        self.assertEqual(events[0].actor, self._test_case_user)
        self.assertEqual(events[0].target, self._test_object)
        self.assertEqual(events[0].verb, self._test_event_type.id)

    def test_notification_list_anonymous_api_view(self):
        self.logout()

        self._clear_events()

        response = self._request_test_notification_list_api_view()
        self.assertEqual(response.status_code, status.HTTP_200_OK)

        events = self._get_test_events()
        self.assertEqual(events.count(), 0)

    def test_notification_list_api_view(self):
        self._clear_events()

        response = self._request_test_notification_list_api_view()
        self.assertEqual(response.status_code, status.HTTP_200_OK)

        events = self._get_test_events()
        self.assertEqual(events.count(), 0)
