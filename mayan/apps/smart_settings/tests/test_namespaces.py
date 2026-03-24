from django.core.exceptions import ImproperlyConfigured

from mayan.apps.smart_settings.utils import get_environment_variable_full_name
from mayan.apps.testing.tests.base import BaseTestCase

from .literals import (
    TEST_SETTING_GLOBAL_NAME, TEST_SETTING_INITIAL_VALUE, TEST_SETTING_VALUE
)
from .mocks import (
    TestNamespaceMigrationInvalid, TestNamespaceMigrationInvalidDual,
    TestNamespaceMigrationOne, TestNamespaceMigrationTwo
)


class SettingNamespaceTestCase(BaseTestCase):
    def test_namespace_add_duplicated(self):
        self._test_setting_namespace_create(name='test_duplicate')

        # Updated in version 4.11.
        # Duplicates raises an exception again.
        with self.assertRaises(expected_exception=ImproperlyConfigured):
            self._test_setting_namespace_create(name='test_duplicate')

    def test_namespace_remove(self):
        self._test_setting_namespace_create(name='test_remove')

        self._test_setting_namespace_remove(name='test_remove')

        self._test_setting_namespace_create(name='test_remove')


class SettingNamespaceMigrationTestCase(BaseTestCase):
    def test_environment_migration(self):
        environment_variable_name = get_environment_variable_full_name(
            name=TEST_SETTING_GLOBAL_NAME
        )
        self._set_environment_variable(
            name=environment_variable_name, value=TEST_SETTING_INITIAL_VALUE
        )
        self._test_setting_namespace_create(
            migration_class=TestNamespaceMigrationOne, version='0002'
        )
        self._create_test_setting()

        self.assertEqual(
            self._test_setting.value, TEST_SETTING_INITIAL_VALUE
        )

    def test_migration_0001_to_0002(self):
        self._test_setting_namespace_create(
            migration_class=TestNamespaceMigrationTwo, version='0002'
        )
        self._create_test_setting()

        self._test_configuration_value = TEST_SETTING_VALUE
        self._create_test_configuration_file()

        self._test_setting_namespace.do_ready()

        self.assertEqual(
            self._test_setting.value, '{}_0001'.format(TEST_SETTING_VALUE)
        )

    def test_migration_0001_to_0003(self):
        self._test_setting_namespace_create(
            migration_class=TestNamespaceMigrationTwo, version='0003'
        )
        self._create_test_setting()

        self._test_configuration_value = TEST_SETTING_VALUE
        self._create_test_configuration_file()

        self._test_setting_namespace.do_ready()

        self.assertEqual(
            self._test_setting.value, '{}_0001_0002'.format(TEST_SETTING_VALUE)
        )

    def test_migration_invalid(self):
        self._test_setting_namespace_create(
            migration_class=TestNamespaceMigrationInvalid, version='0002'
        )
        self._create_test_setting()

        self._test_configuration_value = TEST_SETTING_VALUE
        self._create_test_configuration_file()

        self._test_setting_namespace.do_ready()

        self.assertEqual(
            self._test_setting.value, TEST_SETTING_VALUE
        )

    def test_migration_invalid_dual(self):
        self._test_setting_namespace_create(
            migration_class=TestNamespaceMigrationInvalidDual, version='0002'
        )
        self._create_test_setting()

        self._test_configuration_value = TEST_SETTING_VALUE
        self._create_test_configuration_file()

        self._test_setting_namespace.do_ready()

        self.assertEqual(
            self._test_setting.value, TEST_SETTING_VALUE
        )
