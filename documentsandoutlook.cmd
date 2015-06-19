@echo off
call lib_copias.bat

set logfile=%log_dir%\documentos_y_correo_%log_suf%
set destino=D:\copias_seguridad\%USERNAME%

:: Copia de perfil y correo típica para el usuario de W7 que ejecuta el script:
for %%D in (Desktop,Documents,Pictures,Music,Videos) do (
  %rbcpy% %USERPROFILE%\%%D %destino%\%%D %opts% /LOG+:%logfile%
)

%rbcpy% %USERPROFILE%\AppData\Local\Microsoft\Outlook %destino%\Outlook_AppData %opts% /LOG+:%logfile%

:: siempre respaldar el propio sistema de backup
%rbcpy% %TOOLDIR% %destino%\_backups %opts% /LOG+:%logfile%

