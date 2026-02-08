from mayan.apps.smart_settings.tests.mixins import TestMixinSettingDataType
from mayan.apps.testing.tests.base import BaseTestCase

from ..settings import setting_default_lock_timeout


class LockManagerSettingsTestCase(TestMixinSettingDataType, BaseTestCase):
    def test_setting_default_lock_timeout(self):
        self._test_setting = setting_default_lock_timeout
        self._test_setting_value = 123
        self._do_test_setting_value_set()
