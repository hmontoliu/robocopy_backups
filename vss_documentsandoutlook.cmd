@echo off
:: VSS requiere privilegios elevados (admin, backup operator y/o Performance Log Users) o bien que los binarios tengan privilegios (peligroso)
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
for %%D in (Desktop,Documents,Pictures,Music,Videos) do (
    %rbcpy% %VSSUSERPROFILE%\%%D %destino%\%%D %opts% /LOG+:%logfile%
)
%rbcpy% %VSSUSERPROFILE%\AppData\Local\Microsoft\Outlook %destino%\Outlook_AppData %opts% /LOG+:%logfile%

%DOSDEV% /D %UNIDAD_VSS%

:: siempre respaldar el propio sistema de backup
%rbcpy% %TOOLDIR% %destino%\_backups %opts% /LOG+:%logfile%

:END
