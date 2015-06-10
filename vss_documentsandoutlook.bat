@echo off
:: VSS requiere privilegios elevados
call lib_copias.bat

:: Modificar si procede
set USUARIO=user
set UNIDAD_SRC=C:
set SCRIPTNAME=vss_documentsandoutlook.bat
set VSSUSERPROFILE=%UNIDAD_VSS%\users\%USUARIO%

:: Destino y logfile (ver lib_copias.bat)
set destino=D:\copias_seguridad\%USUARIO%
md %destino%
set logfile=%log_dir%\documentos_y_correo_%log_suf%

if not "%1%"=="VSSBACKUP" goto DO

:VSSBACKUP

%VSCSC% -exec=%RUNDIR%\%SCRIPTNAME% %UNIDAD_SRC%

goto END

:DO

%DOSDEV% %UNIDAD_VSS% %1%

:: Copia de perfil y correo típica para el usuario de W7 que ejecuta el script:
%rbcpy% %VSSUSERPROFILE%\Desktop %destino%\Desktop %opts% /LOG:%logfile%
%rbcpy% %VSSUSERPROFILE%\Documents %destino%\Documents %opts% /LOG:%logfile%
%rbcpy% %VSSUSERPROFILE%\Pictures %destino%\Pictures %opts% /LOG+:%logfile%
%rbcpy% %VSSUSERPROFILE%\Music %destino%\Music %opts% /LOG+:%logfile%
%rbcpy% %VSSUSERPROFILE%\Videos %destino%\Videos %opts% /LOG+:%logfile%
%rbcpy% %VSSUSERPROFILE%\AppData\Local\Microsoft\Outlook %destino%\Outlook_AppData %opts% /LOG+:%logfile%

%DOSDEV% /D %UNIDAD_VSS%

:END
