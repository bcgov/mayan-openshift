from mayan.apps.smart_settings.classes import Setting
from mayan.apps.testing.tests.base import BaseTestCase

from ..settings import setting_storage_backend_arguments


class DocumentSignaturesSettingMigrationTestCase(BaseTestCase):
    def test_signatures_storage_backend_arguments_0001_migration(self):
        test_value = {'location': 'test value'}
        self._test_setting = setting_storage_backend_arguments
        self._test_configuration_value = '{}'.format(
            Setting.serialize_value(value=test_value)
        )
        self._create_test_configuration_file()

        self.assertEqual(
            setting_storage_backend_arguments.value, test_value
        )

    def test_signatures_storage_backend_arguments_0001_migration_with_dict(self):
        test_value = {'location': 'test value'}
        self._test_setting = setting_storage_backend_arguments
        self._test_configuration_value = test_value
        self._create_test_configuration_file()

        self.assertEqual(
            setting_storage_backend_arguments.value, test_value
        )
