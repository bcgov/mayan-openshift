from mayan.apps.smart_settings.tests.mixins import TestMixinSettingDataType
from mayan.apps.testing.tests.base import BaseTestCase

from ..settings import setting_signature_capture_cache_maximum_size


class SignatureCaptureSettingDataTypeTestCase(
    TestMixinSettingDataType, BaseTestCase
):
    def test_setting_signature_capture_cache_maximum_size(self):
        self._test_setting = setting_signature_capture_cache_maximum_size
        self._test_setting_value = 123
        self._do_test_setting_value_set()
