from mayan.apps.smart_settings.tests.mixins import TestMixinSettingDataType
from mayan.apps.testing.tests.base import BaseTestCase

from ..settings import (
    setting_ajax_redirection_code, settings_elided_pager_on_each_side,
    setting_elided_pager_on_ends, setting_max_title_length,
    setting_menu_polling_interval, setting_pagination_dropdown_range, setting_throttling_maximum_requests, setting_throttling_timeout
)


class AppearanceSettingsTestCase(TestMixinSettingDataType, BaseTestCase):
    def test_setting_ajax_redirection_code(self):
        self._test_setting = setting_ajax_redirection_code
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_settings_elided_pager_on_each_side(self):
        self._test_setting = settings_elided_pager_on_each_side
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_elided_pager_on_ends(self):
        self._test_setting = setting_elided_pager_on_ends
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_max_title_length(self):
        self._test_setting = setting_max_title_length
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_menu_polling_interval(self):
        self._test_setting = setting_menu_polling_interval
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_pagination_dropdown_range(self):
        self._test_setting = setting_pagination_dropdown_range
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_throttling_maximum_requests(self):
        self._test_setting = setting_throttling_maximum_requests
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_throttling_timeout(self):
        self._test_setting = setting_throttling_timeout
        self._test_setting_value = 123
        self._do_test_setting_value_set()
