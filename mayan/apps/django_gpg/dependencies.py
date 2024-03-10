from django.utils.translation import gettext_lazy as _

from mayan.apps.dependencies.classes import (
    BinaryDependency, PythonDependency
)

from .backends.python_gnupg import gpg_path

BinaryDependency(
    label='GNU privacy guard', help_text=_(
        'GNU privacy guard - a PGP implementation.'
    ), module=__name__, name='gnupg1', path=gpg_path
)
PythonDependency(
    legal_text='''
        Copyright (c) 2008-2014 by Vinay Sajip.
        All rights reserved.

        Redistribution and use in source and binary forms, with or without
        modification, are permitted provided that the following conditions are met:

            * Redistributions of source code must retain the above copyright notice,
              this list of conditions and the following disclaimer.
            * Redistributions in binary form must reproduce the above copyright notice,
              this list of conditions and the following disclaimer in the documentation
              and/or other materials provided with the distribution.
            * The name(s) of the copyright holder(s) may not be used to endorse or
              promote products derived from this software without specific prior
              written permission.

        THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER(S) "AS IS" AND ANY EXPRESS OR
        IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
        MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
        EVENT SHALL THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY DIRECT, INDIRECT,
        INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
        LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
        PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
        LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
        OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
        ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
    ''', module=__name__, name='python_gnupg', version_string='==0.5.2'
)
