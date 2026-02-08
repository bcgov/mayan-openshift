from mayan.apps.smart_settings.tests.mixins import TestMixinSettingDataType
from mayan.apps.testing.tests.base import BaseTestCase

from ..settings import (
    setting_asset_cache_maximum_size, setting_image_cache_time,
    setting_image_generation_max_retries, setting_image_generation_timeout
)


class ConverterSettingsTestCase(TestMixinSettingDataType, BaseTestCase):
    def test_setting_asset_cache_maximum_size(self):
        self._test_setting = setting_asset_cache_maximum_size
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_image_cache_time(self):
        self._test_setting = setting_image_cache_time
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_image_generation_max_retries(self):
        self._test_setting = setting_image_generation_max_retries
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_image_generation_timeout(self):
        self._test_setting = setting_image_generation_timeout
        self._test_setting_value = 123
        self._do_test_setting_value_set()
