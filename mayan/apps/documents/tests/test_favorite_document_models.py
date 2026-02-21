from django.db import IntegrityError, transaction
from django.test import override_settings

from ..models.favorite_document_models import FavoriteDocument

from .base import GenericDocumentTestCase
from .mixins.favorite_document_mixins import FavoriteDocumentTestMixin


@override_settings(DOCUMENTS_FAVORITE_COUNT=2)
class FavoriteDocumentModelTestCase(
    FavoriteDocumentTestMixin, GenericDocumentTestCase
):
    auto_upload_test_document = False

    def test_favorite_document_unique_per_user_and_document(self):
        self._create_test_document_stub()

        FavoriteDocument.objects.create(
            user=self._test_case_user, document=self._test_document
        )

        with self.assertRaises(IntegrityError):
            # Use `transaction.atomic` to ensure the `IntegrityError` is
            # contained to a savepoint, so the rest of the test
            # infrastructure does not trip over a broken outer transaction.
            with transaction.atomic():
                FavoriteDocument.objects.create(
                    user=self._test_case_user, document=self._test_document
                )

    def test_favorite_documents_deletion_ordering(self):
        self._create_test_document_stub()
        self._test_document_favorite_add()

        first_favorite_document = self._test_favorite_document.document

        self._create_test_document_stub()
        self._test_document_favorite_add()

        self._create_test_document_stub()
        self._test_document_favorite_add()

        self.assertFalse(
            FavoriteDocument.valid.filter(document=first_favorite_document).exists()
        )

    def test_trashed_document_favorite_document_add(self):
        self._create_test_document_stub()
        self._test_document.delete()
        self._test_document_favorite_add()

        self.assertFalse(
            FavoriteDocument.valid.filter(document=self._test_document).exists()
        )
