from mayan.apps.common.serialization import yaml_dump
from mayan.apps.testing.tests.base import BaseTestCase

from ..settings import setting_graphics_backend_arguments, setting_namespace


class ConverterSettingMigrationTestCase(BaseTestCase):
    def test_converter_graphics_backend_arguments_0001_migration(self):
        test_value = {'location': 'test value'}
        self._test_setting = setting_graphics_backend_arguments
        self._test_configuration_value = yaml_dump(data=test_value)
        self._create_test_configuration_file()

        setting_namespace.do_ready()

        self.assertEqual(
            setting_graphics_backend_arguments.value, test_value
        )

    def test_converter_graphics_backend_arguments_0001_migration_with_dict(self):
        test_value = {'location': 'test value'}
        self._test_setting = setting_graphics_backend_arguments
        self._test_configuration_value = test_value
        self._create_test_configuration_file()

        setting_namespace.do_ready()

        self.assertEqual(
            setting_graphics_backend_arguments.value, test_value
        )
