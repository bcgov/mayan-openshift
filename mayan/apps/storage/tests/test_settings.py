import importlib
import logging

from mayan.apps.smart_settings.tests.mixins import TestMixinSettingDataType
from mayan.apps.smart_settings.utils import get_environment_variable_full_name
from mayan.apps.storage import storages
from mayan.apps.testing.tests.base import BaseTestCase

from ..classes import DefinedStorage
from ..literals import STORAGE_NAME_SHARED_UPLOADED_FILE
from ..settings import (
    setting_download_file_expiration_interval,
    setting_shared_storage_arguments,
    setting_shared_uploaded_file_expiration_interval
)


class StorageSettingsTestCase(TestMixinSettingDataType, BaseTestCase):
    def tearDown(self):
        super().tearDown()
        importlib.reload(storages)

    def test_setting_download_file_expiration_interval(self):
        self._test_setting = setting_download_file_expiration_interval
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_shared_uploaded_file_expiration_interval(self):
        self._test_setting = setting_shared_uploaded_file_expiration_interval
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_shared_storage_arguments_invalid_value(self):
        environment_variable_name = get_environment_variable_full_name(
            name=setting_shared_storage_arguments.global_name
        )
        self._set_environment_variable(
            name=environment_variable_name, value='invalid_value'
        )
        self.test_case_silenced_logger_new_level = logging.FATAL + 10
        self._silence_logger(name='mayan.apps.storage.classes')

        with self.assertRaises(expected_exception=TypeError) as assertion:
            importlib.reload(storages)
            defined_storage = DefinedStorage.get(
                name=STORAGE_NAME_SHARED_UPLOADED_FILE
            )
            defined_storage.get_storage_instance()

        self.assertTrue(
            'Unable to initialize' in str(assertion.exception)
        )
        self.assertTrue(
            'shared uploaded' in str(assertion.exception)
        )
