��    H      \  a   �         1   !  2   S  '   �  ,   �     �     �     �     �  9        <     Z     s     �     �     �     �     �     �     �                0  Z   >  �   �  
   4	     ?	  	   G	     Q	     V	  S   [	     �	     �	     �	     �	  .   �	     
  y   
     �
  %   �
     �
     �
     �
  �   �
     �      �  	   �     �          /  4   7  A   l  2   �  F   �  7   (     `     e     �     �  ,   �  &   �  7   �  "   6  X   Y     �     �     �     �  N   �     0  �   G  s  �  �  G  �     w   �  C   	  1   M       .   �  ,   �  
   �  m   �  D   f  5   �  5   �  !        9  1   @  5   r     �  0   �  
   �  5   �  9   1  ,   k  �   �  �     *   �           	          )  �   2     �     �  !   �  *     c   2  ,   �  �   �  7   `  5   �  ?   �          $  ,  :     g  ,   l  
   �  K   �  B   �  
   3  d   >  |   �  Y      T   z  :   �     
   >      1   V   ;   �      �   |   �   �   W!  Z   �!  b   @"     �"     �"  7   �"     �"  �   #  1   �#  �   �#  _  �$        6       /      '   %      
       7               ?                      (             +               0   3   .   5   E      )   "   =   C         @                    D           F   A         G                  &           *   	      ,   :                         4   8   2   #          >            9      -   ;   $   <              1   H   B   !    %(count)d document link queued for email delivery %(count)d document links queued for email delivery %(email)s is not a valid email address. A short text describing the mailing profile. Backend Backend data Backend path Body Body of the email to send. Can be a string or a template. Create a "%s" mailing profile Create a mailing profile Create mailing profile Default Delete Delete a mailing profile Delete mailing profile: %s Django SMTP backend Django file based backend Edit Edit a mailing profile Edit mailing profile: %s Email address Email address of the recipient. Can be multiple addresses separated by comma or semicolon. Email address of the recipient. Can be multiple addresses separated by comma or semicolon. A template can be used to reference properties of the document. Email sent Enabled File path From Host If default, this mailing profile will be pre-selected on the document mailing form. Label Mailer Mailing Mailing profile Mailing profile to use when sending the email. Mailing profiles Mailing profiles are email configurations. Mailing profiles allow sending documents as attachments or as links via email. Mailing profiles list New mailing profile backend selection No mailing profiles available Null backend Password Password to use for the SMTP server. This setting is used in conjunction with the username when authenticating to the SMTP server. If either of these settings is empty, authentication won't be attempted. Port Port to use for the SMTP server. Recipient Send document link via email Send document via email Subject Subject of the email. Can be a string or a template. Template for the document email form body text. Can include HTML. Template for the document email form subject line. Template for the document link email form body text. Can include HTML. Template for the document link email form subject line. Test Test email from Mayan EDMS Test email sent. Test mailing profile: %s The dotted Python path to the backend class. The driver to use when sending emails. The email profile that will be used to send this email. The host to use for sending email. The sender's address. Some system will refuse to send messages if this value is not set. Use SSL Use TLS Use a mailing profile Username Username to use for the SMTP server. If empty, authentication won't attempted. View a mailing profile Whether to use a TLS (secure) connection when talking to the SMTP server. This is used for explicit TLS connections, generally on port 587. Whether to use an implicit TLS (secure) connection when talking to the SMTP server. In most email documentation this type of TLS connection is referred to as SSL. It is generally used on port 465. If you are experiencing problems, see the explicit TLS setting "Use TLS". Note that "Use TLS" and "Use SSL" are mutually exclusive, so only set one of those settings to True. Project-Id-Version: Mayan EDMS
Report-Msgid-Bugs-To: 
PO-Revision-Date: 2023-01-05 02:53+0000
Last-Translator: Marwan Rahhal <Marwanr@sssit.net>, 2023
Language-Team: Arabic (https://www.transifex.com/rosarior/teams/13584/ar/)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Language: ar
Plural-Forms: nplurals=6; plural=n==0 ? 0 : n==1 ? 1 : n==2 ? 2 : n%100>=3 && n%100<=10 ? 3 : n%100>=11 && n%100<=99 ? 4 : 5;
 تم وضع ارتباط الوثيقة %(count)d في قائمة الانتظار لتسليم البريد الإلكتروني %(count)d تم وضع رابط الوثائق في قائمة انتظار تسليم البريد الإلكتروني %(email)s ليس عنوان بريد إلكتروني صالحًا. وصف قالب البريد الإلكتروني في الخفاء بيانات الخاصة بالمبرمجين الرابط الخاص بالمبرمجين الجسم نص البريد الإلكتروني لإرساله. يمكن أن يكون سلسلة أو نموذجًا. إنشاء قالب البريد الإلكتروني &quot;%s&quot; إنشاء قالب البريد الإلكتروني إنشاء قالب للبريد الإلكتروني القيمة الإفتراضية حذف حذف قالب البريد الإلكتروني حذف قالب البريد الإلكتروني: %s خلفية Django SMTP ملف Django القائم على الخلفية تعديل تعديل قالب البريد الإلكتروني تعديل قالب البريد الإلكتروني: %s عنوان البريد الالكترونى يمكن إضافة أكثر من عنوان بريدي مع التأكد من إضافة فاصلة او فاصة منقوطة  يمكن إضافة أكثر من عنوان بريدي مع التأكد من إضافة فاصلة او فاصة منقوطة كما يمكن إضافة قالب محدد للإيميل أرسل البريد الإلكتروني مفعل مسار الملف من عند مضيف سيتم تحديد ملف التعريف هذا مسبقًا في نموذج إرسال االوثائق  بالبريد الإلكتروني. العنوان مراسل رقمي البريد الالكتروني قالب البريد الإلكتروني قالب بريد الكتروني يستخدم عند إرسال البريد الإلكتروني قوالب البريد الإلكتروني تسمح قوالب البريد الإلكتروني بإرسال الوثائق كمرفقات أو كروابط عبر البريد الإلكتروني. قائمة قوالب البريد الإلكتروني تحديد الخلفية الجديدة للقالب لا توجد قوالب بريد الإلكتروني متاح خلفية فارغة كلمة المرور كلمة المرور المراد استخدامها لخادم SMTP. يتم استخدام هذا الإعداد مع اسم المستخدم عند المصادقة على خادم SMTP. إذا كان أي من هذه الإعدادات فارغًا ، فلن تتم محاولة المصادقة. Port منفذ لاستخدامه لخادم SMTP. مستلم أرسال رابط الوثيقة عبر البريد الإلكتروني إرسال الوثيقة عبر البريد الإلكتروني موضوع موضوع البريد الإلكتروني. يمكن أن يكون سلسلة أو نموذجًا. قالب للنص الأساسي لنموذج البريد الإلكتروني للمستند. يمكن أن تشمل HTML. قالب لسطر موضوع نموذج البريد الإلكتروني للمستند. القالب النصي للبريد الإلكتروني لرابط الوثيقة  رابط البريد الإلكتروني للوثيقة  اختبار اختبار البريد الإلكتروني من Mayan EDMS إرسال بريد الكتروني تجريبي اختبار قالب البريد الإلكتروني: %s مسار النظام برنامج التشغيل الذي يجب استخدامه عند إرسال رسائل البريد الإلكتروني. ملف تعريف البريد الإلكتروني الذي سيتم استخدامه لإرسال هذا البريد الإلكتروني. المضيف المراد استخدامه لإرسال البريد الإلكتروني. لا يمكن اتمام عملية الإرسال دون تعبئة القيم الإجبارية استخدم SSL استخدم TLS استخدم قالب البريد الإلكتروني اسم الدخول اسم المستخدم المراد استخدامه لخادم SMTP. إذا كانت فارغة ، فلن تتم محاولة المصادقة. عرض قالب البريد الإلكتروني ما إذا كنت تريد استخدام اتصال TLS (آمن) عند التحدث إلى خادم SMTP. يستخدم هذا لاتصالات TLS الصريحة ، بشكل عام على المنفذ 587. ما إذا كنت تريد استخدام اتصال TLS ضمني (آمن) عند التحدث إلى خادم SMTP. في معظم وثائق البريد الإلكتروني ، يُشار إلى هذا النوع من اتصال TLS باسم SSL. يتم استخدامه بشكل عام على المنفذ 465. إذا كنت تواجه مشكلات ، فراجع إعداد TLS الصريح &quot;استخدام TLS&quot;. لاحظ أن &quot;Use TLS&quot; و &quot;Use SSL&quot; هما حصريان متبادلان ، لذلك عيِّن واحدًا فقط من هذه الإعدادات على True. 