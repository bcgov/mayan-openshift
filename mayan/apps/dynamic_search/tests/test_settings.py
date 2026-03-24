from mayan.apps.smart_settings.tests.mixins import TestMixinSettingDataType
from mayan.apps.testing.tests.base import BaseTestCase

from ..settings import (
    setting_indexing_chunk_size, setting_query_results_limit,
    setting_query_results_limit_error, setting_results_limit,
    setting_saved_resultsets_per_user_limit,
    setting_saved_resultset_results_limit,
    setting_saved_resultset_time_to_live,
    setting_saved_resultset_time_to_live_increment
)


class DynamicSearchSettingsTestCase(TestMixinSettingDataType, BaseTestCase):
    def test_setting_indexing_chunk_size(self):
        self._test_setting = setting_indexing_chunk_size
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_query_results_limit(self):
        self._test_setting = setting_query_results_limit
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_query_results_limit_error(self):
        self._test_setting = setting_query_results_limit_error
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_results_limit(self):
        self._test_setting = setting_results_limit
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_saved_resultsets_per_user_limit(self):
        self._test_setting = setting_saved_resultsets_per_user_limit
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_saved_resultset_results_limit(self):
        self._test_setting = setting_saved_resultset_results_limit
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_saved_resultset_time_to_live(self):
        self._test_setting = setting_saved_resultset_time_to_live
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_saved_resultset_time_to_live_increment(self):
        self._test_setting = setting_saved_resultset_time_to_live_increment
        self._test_setting_value = 123
        self._do_test_setting_value_set()
