��    9      �  O   �      �     �  �     �   �  B  �    �  s  �  d   s
    �
  "   �  +    �   4  #       :    B  �   E  2  �  u  �  Z   t  ^   �  8   .  �   g  �     C   �  �   /  2  �  �   '  �    b   �  �        �!     �"     �"     �"     �"     �"     �"     �"     �"  
   #  
   #     #      #     %#     3#     F#     d#     m#  d   �#     �#    �#  O   %    \%     w&     }&     �&  x  �&  �  (  #   �)  �   �)  	  �*  �  �+  )  P-  �  z.  r   0  �  �0  *   A4  B  l4  �   �6  O  �7     �8    �8  �   :  m  �:  �  <  a   �=  c   8>  <   �>  �   �>  �   �?  K   x@  �   �@  �  �A  (  �E  �  �F  y   �H  �  )I  6  K     ;L     BL     IL     aL     tL  !   |L     �L     �L  
   �L     �L     �L     �L     �L     �L  '   M     ?M     KM  n   dM     �M    �M  V   O  =  ZO     �P     �P     �P  �  �P         4                 /          %                     	      )          8       -                                      3          6   &                !   5      $             0             .          (   #            "      '   1   
   2          9   +           *          7   ,    "%s" not a valid entry. A boolean that specifies whether to use the X-Forwarded-Host header in preference to the Host header. This should only be enabled if a proxy which sets this header is in use. A boolean that specifies whether to use the X-Forwarded-Port header in preference to the SERVER_PORT META variable. This should only be enabled if a proxy which sets this header is in use. USE_X_FORWARDED_HOST takes priority over this setting. A dictionary containing the settings for all databases to be used with Django. It is a nested dictionary whose contents map a database alias to a dictionary containing the options for an individual database. The DATABASES setting must configure a default database; any number of additional databases may also be specified. A list of IP addresses, as strings, that: Allow the debug() context processor to add some variables to the template context. Can use the admindocs bookmarklets even if not logged in as a staff user. Are marked as "internal" (as opposed to "EXTERNAL") in AdminEmailHandler emails. A list of all available languages. The list is a list of two-tuples in the format (language code, language name) for example, ('ja', 'Japanese'). This specifies which languages are available for language selection. Generally, the default value should suffice. Only set this setting if you want to restrict language selection to a subset of the Django-provided languages.  A list of authentication backend classes (as strings) to use when attempting to authenticate a user. A list of strings representing the host/domain names that this site can serve. This is a security measure to prevent HTTP Host header attacks, which are possible even under many seemingly-safe web server configurations. Values in this list can be fully qualified names (e.g. 'www.example.com'), in which case they will be matched against the request's Host header exactly (case-insensitive, not including port). A value beginning with a period can be used as a subdomain wildcard: '.example.com' will match example.com, www.example.com, and any other subdomain of example.com. A value of '*' will match anything; in this case you are responsible to provide your own validation of the Host header (perhaps in a middleware; if so this middleware must be listed first in MIDDLEWARE). A short text used as the tag name. A string representing the language code for this installation. This should be in standard language ID format. For example, U.S. English is "en-us". It serves two purposes: If the locale middleware isn't in use, it decides which translation is served to all users. If the locale middleware is active, it provides a fallback language in case the user's preferred language can't be determined or is not supported by the website. It also provides the fallback translation when a translation for a given literal doesn't exist for the user's preferred language. A string representing the time zone for this installation. Note that this isn't necessarily the time zone of the server. For example, one server may serve multiple Django-powered sites, each with a separate time zone setting. A tuple representing a HTTP header/value combination that signifies a request is secure. This controls the behavior of the request object’s is_secure() method. Warning: Modifying this setting can compromise your site’s security. Ensure you fully understand your setup before changing it. Default Default: '' (Empty string). Password to use for the SMTP server defined in EMAIL_HOST. This setting is used in conjunction with EMAIL_HOST_USER when authenticating to the SMTP server. If either of these settings is empty, Django won't attempt authentication. Default: '' (Empty string). Username to use for the SMTP server defined in EMAIL_HOST. If empty, Django won't attempt authentication. Default: '/accounts/login/' The URL where requests are redirected for login, especially when using the login_required() decorator. This setting also accepts named URL patterns which can be used to reduce configuration duplication since you don't have to define the URL in two places (settings and URLconf). Default: '/accounts/profile/' The URL where requests are redirected after login when the contrib.auth.login view gets no next parameter. This is used by the login_required() decorator, for example. This setting also accepts named URL patterns which can be used to reduce configuration duplication since you don't have to define the URL in two places (settings and URLconf). Default: 'django.contrib.sessions.backends.db'. Controls where Django stores session data. Default: 'django.core.mail.backends.smtp.EmailBackend'. The backend to use for sending emails. Default: 'localhost'. The host to use for sending email. Default: 'sessionid'. The name of the cookie to use for sessions.This can be whatever you want (as long as it's different from the other cookie names in your application). Default: 'webmaster@localhost' Default email address to use for various automated correspondence from the site manager(s). This doesn't include error messages sent to ADMINS and MANAGERS; for that, see SERVER_EMAIL. Default: 25. Port to use for the SMTP server defined in EMAIL_HOST. Default: 2621440 (i.e. 2.5 MB). The maximum size (in bytes) that an upload will be before it gets streamed to the file system. See Managing files for details. See also DATA_UPLOAD_MAX_MEMORY_SIZE. Default: 2621440 (i.e. 2.5 MB). The maximum size in bytes that a request body may be before a SuspiciousOperation (RequestDataTooBig) is raised. The check is done when accessing request.body or request.POST and is calculated against the total request size excluding any file upload data. You can set this to None to disable the check. Applications that are expected to receive unusually large form posts should tune this setting. The amount of request data is correlated to the amount of memory needed to process the request and populate the GET and POST dictionaries. Large requests could be used as a denial-of-service attack vector if left unchecked. Since web servers don't typically perform deep request inspection, it's not possible to perform a similar check at that level. See also FILE_UPLOAD_MAX_MEMORY_SIZE. Default: False. Whether to use a TLS (secure) connection when talking to the SMTP server. This is used for explicit TLS connections, generally on port 587. If you are experiencing hanging connections, see the implicit TLS setting EMAIL_USE_SSL. Default: False. Whether to use an implicit TLS (secure) connection when talking to the SMTP server. In most email documentation this type of TLS connection is referred to as SSL. It is generally used on port 465. If you are experiencing problems, see the explicit TLS setting EMAIL_USE_TLS. Note that EMAIL_USE_TLS/EMAIL_USE_SSL are mutually exclusive, so only set one of those settings to True. Default: None. Specifies a timeout in seconds for blocking operations like the connection attempt. Default: None. The URL where requests are redirected after a user logs out using LogoutView (if the view doesn't get a next_page argument). If None, no redirect will be performed and the logout view will be rendered. This setting also accepts named URL patterns which can be used to reduce configuration duplication since you don't have to define the URL in two places (settings and URLconf). Default: [] (Empty list). List of compiled regular expression objects representing User-Agent strings that are not allowed to visit any page, systemwide. Use this for bad robots/crawlers. This is only used if CommonMiddleware is installed (see Middleware). Django Edit Edit setting: %s Edit settings English Enter the new setting value. Name Namespace: %s, not found Namespaces Overridden Revert Save Setting count Setting namespaces Setting updated successfully. Settings Settings in namespace: %s Settings inherited from an environment variable take precedence and cannot be changed in this view.  Smart settings The full Python path of the WSGI application object that Django's built-in servers (e.g. runserver) will use. The django-admin startproject management command will create a simple wsgi.py file with an application callable in it, and point this setting to that application. The list of validators that are used to check the strength of user's passwords. URL to use when referring to static files located in STATIC_ROOT. Example: "/static/" or "http://static.example.com/" If not None, this will be used as the base path for asset definitions (the Media class) and the staticfiles app. It must end in a slash if set to a non-empty value. Value View settings Warning When set to True, if the request URL does not match any of the patterns in the URLconf and it doesn't end in a slash, an HTTP redirect is issued to the same URL with a slash appended. Note that the redirect may cause any data submitted in a POST request to be lost. The APPEND_SLASH setting is only used if CommonMiddleware is installed (see Middleware). See also PREPEND_WWW. Project-Id-Version: Mayan EDMS
Report-Msgid-Bugs-To: 
PO-Revision-Date: 2024-05-07 07:30+0000
Last-Translator: José Samuel Facundo da Silva <samuel.facundo@ufca.edu.br>, 2024
Language-Team: Portuguese (https://app.transifex.com/rosarior/teams/13584/pt/)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Language: pt
Plural-Forms: nplurals=3; plural=(n == 0 || n == 1) ? 0 : n != 0 && n % 1000000 == 0 ? 1 : 2;
 " %s " não é uma entrada válida. Um booleano que especifica se deve ser usado o cabeçalho X-Forwarded-Host no lugar do cabeçalho Host. Isto apenas deve ser especificado se um proxy que define este cabeça-lho estiver em uso. Um booleano que especifica se deve ser usado o cabeçalho X-Forwarded-Host no lugar da variável SERVER_PORT_META. Isto apenas deve ser especificado se um proxy que define este cabeça-lho estiver em uso. USE_X_FORWARDED_HOST tem precedência sobre este parâmetro. Um dicionário contendo as configurações de todas as bases de dados a serem usadas com Django. Trata-se de um dicionário aninhado cujo conteúdo mapeia pseudônimos de bases de dados para um dicionário contendo as opções para cada base de dados específica. O parâmetro DATABASES deve configurar uma base de dados padrão; qualquer número de bases de dados adicionais deve ser especificado. Uma lista de endereços de IP, como strings, que: Permite que o processador de contexto debug() adicionar algumas variáveis ao template. Pode usar os livretos admindocs mesmo se não estiver logado como staff user. São marcados como "interal" (oposto a "EXTERNAL") nos e-mails AdminEmailHandler. Uma lista de todos os idiomas disponíveis. Esta é uma lista de tuplas no formato (código do idioma, código da língua). Por exemplo: ('pt_BR', 'Português do Brasil'). Isso especifica quais idiomas estão disponíveis para seleção. Geralmente, o valor padrão é suficiente. Apenas defina este parâmetro se você quiser restringir a seleção de idiomas a um subconjunto daquelas fornecidas pelo Django. Uma lista de classes de back-end de autenticação (como strings) a serem usadas ao tentar autenticar um usuário. Uma lista de strings representando os nomes de host/domínio que este site pode utilizar. Esta é uma medida de segurança para prevenir ataques virtuais   que utilizem Host header do protocolo HTTP, os quais são possíveis mesmo sob configurações aparentemente seguras de servidor web. Valores nesta lista podem ser nomes totalmente qualificados (por exemplo 'www.example.com'), que nestes casos coincidirão exatamente com as requisições do Host header (sem considerar maiúsculas ou minúsculas, não incluindo porta). Valores que começam com ponto podem ser usados como curingas para subdomínios: ".example.com" coincidirá com "example.com", "www.example.com" e quaisquer outros subdomínios de "example.com". Um valor de '*' coincidirá com qualquer outro; nesse caso você será responsável porfornecer sua própria validação para o Host header (talvez num middleware; assim sendo o middleware deve ser listado primeiro em MIDDLEWARE). Um texto curto usado como nome da etiqueta Uma string representando o código do idioma para esta instalação. Deve estar em formato padrão de ID de idioma. Por exemplo, inglês estadunidense é "en-us". Serve a dois propósitos: se o middleware de locale não estiver em uso, decide qual tradução será servida a todos os usuários. Se o middleware de locale estiver ativo, fornece um idioma de fallback caso o idioma do usuário não puder ser prederminado ou não for suportado pelo site. Também fornece uma tradução de fallback quando a tradução de determinada literal não existir para o idioma do usuário. Uma string representando a time zone para esta instalação. Note que não necessariamente esta é a time zone do servidor. Por exemplo, um servidor pode servir várias aplicações em Django, cada uma com um parâmetro de time zone. Uma tupla representando uma combinação de cabeçalho/valor HTTP que significa que o recurso é seguro. Isto controla o comportamento do método is_secure() do objeto request. Atenção: modificar este parâmetro pode comprometer  a segurança deste site. Certifique-se de compreender integralmente sua instalação antes de mudá-lo. Padrão Valor padrão: '' (String vazia). Senha utilizada para o servidor SMTP definido em EMAIL_HOST. Este parâmetro é usado junto ao EMAIL_HOST_USER  durante a autenticação no servidor SMTP. Se qualquer um desses parâmetros estiver vazio, Django não tentará a autenticação. Valor padrão '' (String vazia). Nome de usuário utilizado para o servidor SMTP definido em EMAIL_HOST. Se estiver vazio, Django não tentará a autenticação. Valor padrão: '/accounts/login/' A URL onde as requisições são redirecionadas para iniciar a sessão, especialmente quando se utiliza o decorador login_required(). Este parâmetro também aceita padrões de URL que podem ser usados para reduzir a duplicação de parâmetros, uma vez que você não precisa definir a URL em dois lugares (parâmetros e URLconf). Valor padrão: '/accounts/profile/' A URL para onde são redirecionadas as requisições após o início da sessão quando a vista contrib.auth.login não obtêm o próximo parâmetro. Isto é utilizado pelo decorador login_required() , por exemplo. Este parâmetro também aceita padrões de URL que podem ser usados para reduzir a duplicação de parâmetros, uma vez que você não precisa definir a URL em dois lugares (parâmetros e URLconf). 'django.contrib.sessions.backends.db' default;. Controla onde o Django armazena dados da sessão. Valor padrão: 'django.core.mail.backends.smtp.EmailBackend'. O back-end usado para enviar e-mails. Valor padrão: 'localhost'. O host usado para enviar e-mail. 'sessionid' default;. O nome do cookie a ser usado nas sessões. Este pode ser o que você quiser, desde que seja diferente dos outros nomes de cookies no seu aplicativo. Padrão: 'webmaster@localhost'. Endereço padrão de e-mail a ser usado para várias correspondências automáticas dos administradores do site. Isto não inclui mensagens de erro enviadas para ADMINS e MANAGERS; para tanto, veja SERVER_EMAIL. Valor padrão: 25. Porta usada para o servidor SMTP definido em EMAIL_HOST. Valor padrão: 2621440 (i.e. 2.5MB). O tamanho máximo (em bytes) que um upload terá antes de ser transmitida ao sistema de arquivos. Veja Administração de arquivos para detalhes. Veja ainda DATA_UPLOAD_MAX_MEMORY_SIZE. Valor padrão: 2621440 (i.e. 2.5MB). O tamanho máximo em bytes que um corpo de requisição pode atingir antes que se gere uma Operação Suspeita (RequestDataTooBig). A checagem é feita quando se acessa request.body ou request.POST e é calculada em relação ao tamanho total da solicitação, excluindo qualquer arquivo de carga de dados. Você pode configurá-la para None para desativar a verificação. Aplicações para as quais se esperam POSTs de tamanho muito grande devem ajustar esse parâmetro. A quantidade de dados da requisição está correlacionada com a quantidade de memória necessária para processá-la e povoar os dicionários GET e POST. As requisições grandes podem ser usadas como vetor de ataques de negação de serviço - "denial-of-service" - caso o parâmetro não seja preenchido. Dado que os servidores web normalmente não realizam uma inspeção profunda das requisições, não é possível realizar uma verificação similar nesse nível. Veja também FILE_UPLOAD_MAX_MEMORY_SIZE. Valor padrão: False. Define se deve ser utilizada uma conexão TLS (segura) quando se comunica com o servidor SMTP. Isto é usado para conexões explícitas de TLS, geralmente na porta 587. Se você está experimentando conexões suspensas, consulte o parâmetro de TLS implícita EMAIL_USE_SSL. Valor padrão: False. Define se deve ser utilizada uma conexão implícita TLS (segura) ao comunicar-se com o servidor SMTP. Na maior parte da documentação de e-mail este tipo de conexão TLS é conhecida como SSL. Geralmente é usada a porta 465. Se você está experimentando problemas, veja o parâmetro de TSL explícita EMAIL_USE_TLS. Tenha em mente que EMAIL_USE_TLS / EMAIL_USE_SSL são mutuamente excludentes, razão pela qual apenas um dos parâmetros pode ser Verdadeiro. Valor padrão: None. Especifica um tempo de espera em segundos para operações de bloqueio, como tentativas de conexão. Padrão: None. A URL para qual as requisições são redirecionadas depois que um usuário sai do sistema (logout) usando LogoutView (se a view não recebe um aregumento next_page). Se None, nenhum redirecionamento será realizado e a tela de logout será renderizada. Este parâmetro também aceita padrões nomeados de URL que podem ser usados para reduzir a duplicação de parâmetros, já que você não precisará de definir a URL em dois lugares (settings e URLconf). Valor padrão: [] (Lista vazia). Lista de objetos de expressões regulares compilados representando strings de User-Agent que não tem permissão para visitar nenhuma página em todo o sistema. Use contra maus robôs/rastradores. Este parâmetro só é usado com o CommonMiddleware instalado (veja Middleware). Django Editar Editar o parâmetro: %s Editar parâmetros Inglês Entre o novo valor do parâmetro. Nome Namespace: %s, não encontrad Categorias Sobrescrito Reverter Guardar Contagem de ajustes Categorias de parâmetros Configurações atualizadas com sucesso Parâmetros Ajustes na categoria: %s Configurações herdadas de uma variável de ambiente têm precedência e não podem ser alteradas nesta tela. Ajustes inteligentes O caminho Python completo do objeto de aplicação WSGI que o servidor embutido do Django usa (por exemplo, runserver). O comando django-admin startproject irá criar um arquivo wsgi.py simples com uma applicação callable nele, e apontará este parâmetro para aquela aplicação. A lista de validadores que são usados para validar a força das senhas dos usuários. URL a ser usada quando se referir aos arquivos estáticos contidos em STATIC_ROOT. Exemplo: "/static/" ou "http://static.example.com/". Se não for None, será usada como caminho base para definições de recursos (a classe Media) e a app staticfiles. Deve terminar com uma barra se definida para um valor não vazio. Valor Ver parâmetros Aviso Quando indicado como True, caso a URL requisitada não coincida com os padrões na URLconf e não termine com uma barra, haverá um redirecionamento HTTP para a mesma URL com uma barra adicionada. Note que o redirecionamento pode fazer com que quaisquer dados submetidos numa requisição POST sejam perdidos.  O parâmetro APPEND_SLASH é usada apenas se o CommonMiddleware estiver instalado (veja Middleware). Veja também PREPEND_WWW. 