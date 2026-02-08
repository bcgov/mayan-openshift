from mayan.apps.documents import storages
from mayan.apps.smart_settings.tests.mixins import TestMixinSettingDataType
from mayan.apps.storage.tests.mixins import StorageSettingTestMixin
from mayan.apps.testing.tests.base import BaseTestCase
from mayan.settings.literals import ENVIRONMENT_VARIABLE_PREFIX

from ..literals import (
    STORAGE_NAME_DOCUMENT_FILE_PAGE_IMAGE_CACHE, STORAGE_NAME_DOCUMENT_FILES,
    STORAGE_NAME_DOCUMENT_VERSION_PAGE_IMAGE_CACHE
)
from ..settings import (
    setting_display_height, setting_display_width,
    setting_document_file_page_image_cache_maximum_size,
    setting_document_file_page_image_cache_storage_backend_arguments,
    setting_document_file_storage_backend_arguments,
    setting_document_version_page_image_cache_maximum_size,
    setting_document_version_page_image_cache_storage_backend_arguments,
    setting_favorite_count, setting_hash_block_size, setting_language_codes,
    setting_preview_height, setting_preview_width, setting_print_height,
    setting_print_width, setting_recently_accessed_document_count,
    setting_recently_created_document_count, setting_rotation_step,
    setting_task_document_type_document_trash_periods_check_interval,
    setting_task_document_type_document_stubs_delete_interval,
    setting_task_trashed_document_delete_periods_check_interval,
    setting_thumbnail_height, setting_thumbnail_width,
    setting_thumbnail_list_width, setting_zoom_max_level,
    setting_zoom_min_level, setting_zoom_percent_step
)


class DocumentFileStorageSettingsTestCase(
    StorageSettingTestMixin, BaseTestCase
):
    def test_setting_document_file_storage_backend_arguments_invalid_value(self):
        assertion = self._test_storage_setting_with_invalid_value(
            setting=setting_document_file_storage_backend_arguments,
            storage_module=storages,
            storage_name=STORAGE_NAME_DOCUMENT_FILES
        )

        self.assertTrue(
            'Unable to initialize' in str(assertion.exception)
        )
        self.assertTrue(
            'document file storage' in str(assertion.exception)
        )

    def test_setting_document_file_page_image_cache_maximum_size(self):
        old_value = setting_document_file_page_image_cache_maximum_size.value
        new_value = old_value + 1
        setting_document_file_page_image_cache_maximum_size.do_value_override(
            value='{}'.format(new_value)
        )

        self.assertEqual(
            setting_document_file_page_image_cache_maximum_size.value,
            new_value
        )

    def test_setting_document_file_page_image_cache_storage_backend_arguments_invalid_value(self):
        assertion = self._test_storage_setting_with_invalid_value(
            setting=setting_document_file_page_image_cache_storage_backend_arguments,
            storage_module=storages,
            storage_name=STORAGE_NAME_DOCUMENT_FILE_PAGE_IMAGE_CACHE
        )

        self.assertTrue(
            'Unable to initialize' in str(assertion.exception)
        )
        self.assertTrue(
            'document file image storage' in str(assertion.exception)
        )


class DocumentSettingDataTypeTestCase(TestMixinSettingDataType, BaseTestCase):
    def test_setting_display_height(self):
        self._test_setting = setting_display_height
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_display_width(self):
        self._test_setting = setting_display_width
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_document_file_page_image_cache_maximum_size(self):
        self._test_setting = setting_document_file_page_image_cache_maximum_size
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_document_version_page_image_cache_maximum_size(self):
        self._test_setting = setting_document_version_page_image_cache_maximum_size
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_favorite_count(self):
        self._test_setting = setting_favorite_count
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_hash_block_size(self):
        self._test_setting = setting_hash_block_size
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_preview_height(self):
        self._test_setting = setting_preview_height
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_preview_width(self):
        self._test_setting = setting_preview_width
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_print_height(self):
        self._test_setting = setting_print_height
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_print_width(self):
        self._test_setting = setting_print_width
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_recently_accessed_document_count(self):
        self._test_setting = setting_recently_accessed_document_count
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_recently_created_document_count(self):
        self._test_setting = setting_recently_created_document_count
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_rotation_step(self):
        self._test_setting = setting_rotation_step
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_task_document_type_document_trash_periods_check_interval(self):
        self._test_setting = setting_task_document_type_document_trash_periods_check_interval
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_task_document_type_document_stubs_delete_interval(self):
        self._test_setting = setting_task_document_type_document_stubs_delete_interval
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_task_trashed_document_delete_periods_check_interval(self):
        self._test_setting = setting_task_trashed_document_delete_periods_check_interval
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_thumbnail_height(self):
        self._test_setting = setting_thumbnail_height
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_thumbnail_width(self):
        self._test_setting = setting_thumbnail_width
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_thumbnail_list_width(self):
        self._test_setting = setting_thumbnail_list_width
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_zoom_max_level(self):
        self._test_setting = setting_zoom_max_level
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_zoom_min_level(self):
        self._test_setting = setting_zoom_min_level
        self._test_setting_value = 123
        self._do_test_setting_value_set()

    def test_setting_zoom_percent_step(self):
        self._test_setting = setting_zoom_percent_step
        self._test_setting_value = 123
        self._do_test_setting_value_set()


class DocumentSettingsTestCase(BaseTestCase):
    def test_documents_language_codes_setting_double_quotes(self):
        self._set_environment_variable(
            name='{}{}'.format(
                ENVIRONMENT_VARIABLE_PREFIX,
                setting_language_codes.global_name
            ), value='["spa","fra"]'
        )

        self.assertEqual(
            setting_language_codes.value,
            ['spa', 'fra']
        )

    def test_documents_language_codes_setting_single_quotes(self):
        self._set_environment_variable(
            name='{}{}'.format(
                ENVIRONMENT_VARIABLE_PREFIX,
                setting_language_codes.global_name
            ), value="['spa','deu']"
        )

        self.assertEqual(
            setting_language_codes.value,
            ['spa', 'deu']
        )


class DocumentVersionStorageSettingsTestCase(
    StorageSettingTestMixin, BaseTestCase
):
    def test_setting_document_version_page_image_cache_storage_backend_arguments_invalid_value(self):
        assertion = self._test_storage_setting_with_invalid_value(
            setting=setting_document_version_page_image_cache_storage_backend_arguments,
            storage_module=storages,
            storage_name=STORAGE_NAME_DOCUMENT_VERSION_PAGE_IMAGE_CACHE
        )

        self.assertTrue(
            'Unable to initialize' in str(assertion.exception)
        )
        self.assertTrue(
            'document version image storage' in str(assertion.exception)
        )

    def test_setting_document_version_page_image_cache_maximum_size_callback(self):
        old_value = setting_document_version_page_image_cache_maximum_size.value
        new_value = old_value + 1
        setting_document_version_page_image_cache_maximum_size.do_value_override(
            value='{}'.format(new_value)
        )

        self.assertEqual(
            setting_document_version_page_image_cache_maximum_size.value,
            new_value
        )
