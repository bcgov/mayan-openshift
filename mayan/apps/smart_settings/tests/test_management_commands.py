from pathlib import Path

from django.conf import settings

from mayan.apps.common.tests.mixins import ManagementCommandTestMixin
from mayan.apps.storage.utils import fs_cleanup
from mayan.apps.testing.tests.base import BaseTestCase

from ..setting_clusters import setting_cluster

from .literals import (
    COMMAND_NAME_SETTINGS_REVERT, COMMAND_NAME_SETTINGS_SAVE,
    COMMAND_NAME_SETTINGS_SHOW
)


class SettingsManagementCommandTestCase(
    ManagementCommandTestMixin, BaseTestCase
):
    def test_settings_revert(self):
        self._test_management_command_name = COMMAND_NAME_SETTINGS_REVERT

        _setting_old_value = settings.SETTINGS_BACKUP_ENABLED
        settings.SETTINGS_BACKUP_ENABLED = True

        setting_cluster.do_ready()

        settings.SETTINGS_BACKUP_ENABLED = _setting_old_value

        path_config = Path(settings.CONFIGURATION_FILEPATH)
        path_config_backup = Path(settings.CONFIGURATION_LAST_GOOD_FILEPATH)

        with path_config_backup.open() as file_object:
            config_backup_content = file_object.read()

        fs_cleanup(
            filename=str(path_config)
        )

        self.assertFalse(
            path_config.exists()
        )

        stdout, stderr = self._call_test_management_command()

        self.assertFalse(stdout)
        self.assertFalse(stderr)

        with path_config.open() as file_object:
            config_content = file_object.read()

        self.assertEqual(config_content, config_backup_content)

    def test_settings_save(self):
        self._test_management_command_name = COMMAND_NAME_SETTINGS_SAVE

        path_config = Path(settings.CONFIGURATION_FILEPATH)

        self._test_setting_namespace_create()
        self._create_test_setting()
        test_value = 'config_test_value123'
        self._test_setting.do_value_pending_set(value=test_value)

        fs_cleanup(
            filename=str(path_config)
        )

        self.assertFalse(
            path_config.exists()
        )

        stdout, stderr = self._call_test_management_command()

        self.assertFalse(stdout)
        self.assertFalse(stderr)

        with path_config.open() as file_object:
            config_content = file_object.read()
            self.assertTrue(test_value in config_content)

    def test_settings_show(self):
        self._test_management_command_name = COMMAND_NAME_SETTINGS_SHOW

        stdout, stderr = self._call_test_management_command()
        self.assertTrue(stdout)
        self.assertFalse(stderr)
