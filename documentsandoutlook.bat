@echo off
call lib_copias.bat

:: Copia de perfil y correo típica para el usuario de W7 que ejecuta el script:
set logfile=%log_dir%\documentos_y_correo_%log_suf%
set destino=D:\copias_seguridad\%USERNAME%
%rbcpy% %USERPROFILE%\Desktop %destino%\Desktop %opts% /LOG:%logfile%
%rbcpy% %USERPROFILE%\Documents %destino%\Documents %opts% /LOG+:%logfile%
%rbcpy% %USERPROFILE%\Pictures %destino%\Pictures %opts% /LOG+:%logfile%
%rbcpy% %USERPROFILE%\Music %destino%\Music %opts% /LOG+:%logfile%
%rbcpy% %USERPROFILE%\Videos %destino%\Videos %opts% /LOG+:%logfile%
%rbcpy% %USERPROFILE%\AppData\Local\Microsoft\Outlook %destino%\Outlook_AppData %opts% /LOG+:%logfile%

:: alternativa
::  for %%D in (Desktop,Documents,Pictures,Music,Videos) do (
::    %rbcpy% %VSSUSERPROFILE%\%D %destino%\%%D %opts% /LOG+:%logfile%
::  )



