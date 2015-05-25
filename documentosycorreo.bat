@echo off
call lib_copias.bat

:: Copia de perfil y correo típica para el usuario de W7 que ejecuta el script:
set logfile=%log_dir%\documentos_y_correo_%log_suf%
set destino=D:\copias_seguridad\%USERNAME%
%rbcpy% %USERPROFILE%\Documents %destino%\Documents %opts% /LOG:%logfile%
%rbcpy% %USERPROFILE%\Pictures %destino%\Pictures %opts% /LOG+:%logfile%
%rbcpy% %USERPROFILE%\Music %destino%\Music %opts% /LOG+:%logfile%
%rbcpy% %USERPROFILE%\Videos %destino%\Videos %opts% /LOG+:%logfile%
%rbcpy% %USERPROFILE%\AppData\Local\Microsoft\Outlook %destino%\Outlook_AppData %opts% /LOG+:%logfile%





