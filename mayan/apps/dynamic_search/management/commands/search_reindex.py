from django.core.management.base import BaseCommand

from ...tasks import task_reindex_backend
from ...settings import setting_search_disable


class Command(BaseCommand):
    help = 'Erases and populates the search backend internal indexes.'

    def handle(self, *args, **options):
        if not setting_search_disable.value:
            task_reindex_backend.apply_async()
