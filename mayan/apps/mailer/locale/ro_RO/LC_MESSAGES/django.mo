��    k      t  �   �       	  6   !	  7   X	  1   �	  2   �	  1   �	  2   '
  9   Z
  :   �
  4   �
  5     '   :  ,   b  �   �  �   C     �  2     �   N  
   �     �     �     �            9        N     Q     o     �     �     �     �     �     �     �               #     :     S  Z   a  �   �     W     k     �     �     �     �  
   �     �  	   �     �        S        Y  (   _     �     �     �     �     �  .   �       y        �  %   �     �     �     �  �         �      �  	   �     �  !        '     D  $   a     �     �     �     �     �  4   �  A     2   _  F   �  7   �               1     B  ,   [  &   �  7   �  "   �  X   
  �   c     �               #  N   ,     {  �   �  s       �  �  �  Z   M  Y   �  H     K   K  L   �  R   �  S   7  Y   �  N   �  Q   4  .   �  .   �  �   �  �   �      �!  4   �!  �   "     �"     �"     �"     �"     �"     �"  =   �"     
#  .   #  $   <#  1   a#     �#     �#  '   �#  /   �#     �#  #   $     4$     E$  %   N$  -   t$     �$  i   �$  �   %  )   �%  <   �%  *   ;&  -   f&  4   �&  )   �&     �&      '     '     '      '  w   ''     �'  +   �'     �'     �'     (  &   ,(  )   S(  I   }(     �(  �   �(  &   q)  9   �)  5   �)     *     *  �   *     +  %   +  
   -+     8+  2   D+  -   w+  +   �+  4   �+  -   ,  !   4,     V,     e,     �,  6   �,  =   �,  ;   -  [   >-  9   �-     �-  %   �-     �-  *   .  (   D.  F   m.  D   �.  1   �.  j   +/  �   �/     >0     M0  '   \0     �0  e   �0  )   �0  �   '1  �  �1     �3     C   0       3                   1                       @                 h   M       	       ]          e   K       +   d   2   )   b           <   P   _   E                      ^   >   c   Y   a         #       k   6              !   \   R              =   4   &           /      A       Q          V   9   X   *      j   :                 Z   [           .      T           %   ?      "   S   8   f       L   ;       ,   U      `       G      (   J                '   F   D          B   
   g                 $   N   5   i   W   H   -          O   7   I        %(count)d document file link queued for email delivery %(count)d document file links queued for email delivery %(count)d document file queued for email delivery %(count)d document files queued for email delivery %(count)d document link queued for email delivery %(count)d document links queued for email delivery %(count)d document version link queued for email delivery %(count)d document version links queued for email delivery %(count)d document version queued for email delivery %(count)d document versions queued for email delivery %(email)s is not a valid email address. A short text describing the mailing profile. Address used in the "Bcc" header when sending the email. Can be multiple addresses separated by comma or semicolon. A template can be used to reference properties of the document. Address used in the "Reply-To" header when sending the email. Can be multiple addresses separated by comma or semicolon. A template can be used to reference properties of the document. Attach an object to the email. Attach the exported document version to the email. Attached to this email is the {{ object_name }}: {{ object }}

 --------
 This email has been sent from %(project_title)s (%(project_website)s) Attachment BCC Backend Backend data Backend path Body Body of the email to send. Can be a string or a template. CC Create a "%s" mailing profile Create a mailing profile Create mailing profile Default Delete Delete a mailing profile Delete mailing profile: %s Django SMTP backend Django file based backend Document file Edit Edit a mailing profile Edit mailing profile: %s Email address Email address of the recipient. Can be multiple addresses separated by comma or semicolon. Email address of the recipient. Can be multiple addresses separated by comma or semicolon. A template can be used to reference properties of the document. Email document file Email document file link Email document link Email document version Email document version link Email link version Email sent Enabled File path From Host If default, this mailing profile will be pre-selected on the document mailing form. Label Link for {{ object_name }}: {{ object }} Mailer Mailing Mailing profile Mailing profile created Mailing profile edited Mailing profile to use when sending the email. Mailing profiles Mailing profiles are email configurations. Mailing profiles allow sending documents as attachments or as links via email. Mailing profiles list New mailing profile backend selection No mailing profiles available Null backend Password Password to use for the SMTP server. This setting is used in conjunction with the username when authenticating to the SMTP server. If either of these settings is empty, authentication won't be attempted. Port Port to use for the SMTP server. Recipient Reply to Send document file link via email Send document file via email Send document link via email Send document version link via email Send document version via email Send document via email Send object Send object via email Subject Subject of the email. Can be a string or a template. Template for the document email form body text. Can include HTML. Template for the document email form subject line. Template for the document link email form body text. Can include HTML. Template for the document link email form subject line. Test Test email from Mayan EDMS Test email sent. Test mailing profile: %s The dotted Python path to the backend class. The driver to use when sending emails. The email profile that will be used to send this email. The host to use for sending email. The sender's address. Some system will refuse to send messages if this value is not set. To access this {{ object_name }} click on the following link: {{ link }}

--------
 This email has been sent from %(project_title)s (%(project_website)s) Use SSL Use TLS Use a mailing profile Username Username to use for the SMTP server. If empty, authentication won't attempted. View a mailing profile Whether to use a TLS (secure) connection when talking to the SMTP server. This is used for explicit TLS connections, generally on port 587. Whether to use an implicit TLS (secure) connection when talking to the SMTP server. In most email documentation this type of TLS connection is referred to as SSL. It is generally used on port 465. If you are experiencing problems, see the explicit TLS setting "Use TLS". Note that "Use TLS" and "Use SSL" are mutually exclusive, so only set one of those settings to True. {{ object_name }}: {{ object }} Project-Id-Version: Mayan EDMS
Report-Msgid-Bugs-To: 
PO-Revision-Date: 2023-01-05 02:53+0000
Last-Translator: Harald Ersch, 2023
Language-Team: Romanian (Romania) (https://app.transifex.com/rosarior/teams/13584/ro_RO/)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Language: ro_RO
Plural-Forms: nplurals=3; plural=(n==1?0:(((n%100>19)||((n%100==0)&&(n!=0)))?2:1));
 Link-ul %(count)d pentru fișierul documentului pus în coadă pentru livrarea prin e-mail %(count)d link-uri la fișierele documentelor puse în coadă pentru livrarea prin e-mail  Fișierul document %(count)d pus în coadă pentru livrarea prin e-mail %(count)d fișiere de documente puse în coadă pentru livrarea prin e-mail %(count)d link de document a fost pus în coadă pentru livrarea prin e-mail %(count)d linkuri de documente au fost puse în coadă pentru livrarea prin e-mail Linkul versiunii documentului %(count)d  pus în coadă pentru livrarea prin e-mail %(count)d link-uri ale versiunii documentului puse în coadă pentru livrarea prin e-mail Versiunea documentului %(count)d  pusă în coadă pentru livrarea prin e-mail %(count)d versiuni ale documentului aflate în coadă pentru livrarea prin e-mail %(email)s nu este o adresă de e-mail validă. Un text scurt care descrie profilul de e-mail. Adresa folosită în antetul „Bcc” la trimiterea e-mailului. Pot fi mai multe adrese separate prin virgulă sau punct și virgulă. Un șablon poate fi utilizat pentru a face referire la proprietățile documentului. Adresa folosită în antetul „Răspuns la” atunci când trimiteți e-mailul. Pot fi mai multe adrese separate prin virgulă sau punct și virgulă. Un șablon poate fi utilizat pentru a face referire la proprietățile documentului. Atașați un obiect la e-mail. Atașați versiunea documentului exportat la e-mail. La acest e-mail este atașat {{ object_name }}: {{ object }} 

-------- 
Acest e-mail a fost trimis de la %(project_title)s (%(project_website)s) Atașare BCC Backend Date backend Calea de backend Corp Corpul e-mailului de trimis. Poate fi un șir sau un șablon. CC Creați un profil de poștă electronică "%s" Creați un profil de corespondență Creați un profil de corespondență electronică Implicit Șterge Ștergeți un profil de corespondență Ștergeți profilul de poștă electronică: %s Django SMTP backend Backend Django pe bază de fișiere Fișier document Editați Editați un profil de corespondență Editați profilul de poștă electronică: %s Adresa de email Adresa de e-mail a destinatarului. Pot fi mai multe adrese separate prin virgulă sau punct și virgulă. Adresa de e-mail a destinatarului. Pot fi mai multe adrese separate prin virgulă sau punct și virgulă. Un șablon poate fi utilizat pentru referința proprietăților documentului. Trimiteți prin e-mail fișierul document Trimiteți prin e-mail un link pentru fișierul documentului Trimiteți prin e-mail linkul documentului Trimiteți versiunea documentului prin e-mail Trimiteți prin e-mail linkul versiunii documentului Trimiteți versiunea linkului prin e-mail Email trimis Activat Calea fișierului De la Gazdă Dacă este implicit, acest profil de poștă electronică va fi pre-selectat pe formularul de trimitere a documentelor. Conținut etichetă Link pentru {{ object_name }}: {{ object }} Poștă electronică Corespondență electonică Profilul de corespondență Profil de corespondență a fost creat Profilul de corespondență a fost editat Profil de corespondență pe care îl folosiți la trimiterea e-mailului. Profiluri de corespondență Profilurile de corespondență sunt configurații de e-mail. Ele permit trimiterea documentelor ca atașamente sau ca legături prin e-mail. Listă de profiluri de corespondență Selecție nouă de profil backend de poștă electronică Nu sunt disponibile profiluri de poștă electronică Backend vid Parola Parolă de utilizat pentru serverul SMTP. Această setare este utilizată împreună cu numele de utilizator când se autentifică pe serverul SMTP. Dacă una dintre aceste setări este goală, autentificarea nu va fi încercată. Port Port de folosit pentru serverul SMTP. Destinatar Răspuns la Trimiteți linkul fișierului document prin e-mail Trimiteți fișierul documentului prin e-mail Trimiteți link-ul documentului prin e-mail Trimiteți linkul versiunii documentului prin e-mail Trimiteți versiunea documentului prin e-mail Trimiteți documentul prin e-mail Trimite obiect Trimiteți obiectul prin e-mail Subiect Subiectul e-mailului. Poate fi un șir sau un șablon. Șablon pentru textul corpului mail-ului. Poate include HTML. Șablon pentru subiectul liniei de subiecte a documentului. Șablon pentru corpul formularul de e-mail pentru link-ul documentului. Poate include HTML. Șablon pentru subiectul liniei de e-mail a documentului. Test E-mail de încercare de la Mayan EDMS E-mail de testare trimis. Testare profil de poștă electronică: %s Calea Python punctată la clasa backend. Pilotul software ce trebuie folosit atunci când trimiteți e-mailuri. Profilul de e-mail care va fi folosit pentru a trimite acest e-mail. Gazda de utilizat pentru trimiterea de e-mailuri. Adresa expeditorului. Unele sisteme vor refuza să trimită mesaje dacă această valoare nu este setată. Pentru a accesa acest {{ object_name }} faceți clic pe următorul link: {{ link }}

--------
 Acest e-mail a fost trimis de la %(project_title)s (%(project_website)s) Utilizați SSL Utilizați TLS Utilizați un profil de corespondență Nume de utilizator Nume de utilizator de folosit pentru serverul SMTP. Dacă este gol, nu se va încerca autentificarea. Vizualizați un profil de corespondență Dacă să utilizați o conexiune TLS (securizată) atunci când vorbiți cu serverul SMTP. Acesta este utilizat pentru conexiuni TLS explicite, în general pe portul 587. Dacă să utilizați o conexiune implicită TLS (securizată) atunci când vorbiți cu serverul SMTP. În majoritatea documentelor de e-mail, acest tip de conexiune TLS este denumit SSL. Este utilizat în general la portul 465. Dacă întâmpinați probleme, consultați setarea explicită TLS "Utilizați TLS". Rețineți că "Utilizați TLS" și "Utilizați SSL" se exclud reciproc, deci setați numai una dintre aceste setări la True. {{ object_name }}: {{ object }} 