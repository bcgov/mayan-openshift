from django.utils.translation import ugettext_lazy as _

from .classes import CredentialBackend


class CredentialBackendAccessToken(CredentialBackend):
    form_field_widgets = {
        'token': {
            'class': 'django.forms.widgets.PasswordInput',
            'kwargs': {
                'render_value': True
            }
        }
    }
    form_fields = {
        'token': {
            'label': _('Token'),
            'class': 'django.forms.CharField', 'default': '',
            'help_text': _(
                'Generated token value used to make API calls.'
            ), 'kwargs': {
                'max_length': 255
            }, 'required': True
        }
    }
    label = _('Access token')

    @classmethod
    def get_form_fieldsets(cls):
        fieldsets = super().get_form_fieldsets()

        fieldsets += (
            (
                _('Identity'), {
                    'fields': ('token',)
                }
            ),
        )

        return fieldsets


class CredentialBackendUsernamePassword(CredentialBackend):
    form_field_widgets = {
        'password': {
            'class': 'django.forms.widgets.PasswordInput',
            'kwargs': {
                'render_value': True
            }
        }
    }
    form_fields = {
        'username': {
            'label': _('Username'),
            'class': 'django.forms.CharField', 'default': '',
            'help_text': _(
                'Pseudonym used to identify a user.'
            ), 'kwargs': {
                'max_length': 254
            }, 'required': True
        }, 'password': {
            'label': _('Password'),
            'class': 'django.forms.CharField', 'default': '',
            'help_text': _(
                'Character string used to authenticate the user.'
            ), 'kwargs': {
                'max_length': 192
            }, 'required': False
        }
    }
    label = _('Username and password')

    @classmethod
    def get_form_fieldsets(cls):
        fieldsets = super().get_form_fieldsets()

        fieldsets += (
            (
                _('Identity'), {
                    'fields': ('username', 'password')
                }
            ),
        )

        return fieldsets
