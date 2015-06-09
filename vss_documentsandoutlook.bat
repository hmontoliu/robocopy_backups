@echo off
call lib_copias.bat
call lib_vss.bat


:: Copia de perfil y correo típica para el usuario de W7 que ejecuta el script:
set logfile=%log_dir%\documentos_y_correo_%log_suf%
set destino=D:\copias_seguridad\%USERNAME%
%rbcpy% %USERPROFILE%\Desktop %destino%\Desktop %opts% /LOG:%logfile%
%rbcpy% %USERPROFILE%\Documents %destino%\Documents %opts% /LOG:%logfile%
%rbcpy% %USERPROFILE%\Pictures %destino%\Pictures %opts% /LOG+:%logfile%
%rbcpy% %USERPROFILE%\Music %destino%\Music %opts% /LOG+:%logfile%
%rbcpy% %USERPROFILE%\Videos %destino%\Videos %opts% /LOG+:%logfile%
%rbcpy% %USERPROFILE%\AppData\Local\Microsoft\Outlook %destino%\Outlook_AppData %opts% /LOG+:%logfile%


set RUNDIR="C:"

if not "%1%"=="WINSCHED" goto DO

:WINSCHED

vscsc -exec=%RUNDIR%\robocopy-sample.bat C:

goto END

:DO

rem Name of the log file, to get some info about what's going on with robocopy
set LOGFILE=%RUNDIR%\robocopy.log

rem DOS Volume Name to be assigned to the snapshot
set SNAPDOS=B:

rem Backup Documents and Settings folder
set DOCS_SRC=%SNAPDOS%\Documents and Settings
set DOCS_DST=C:\Documents and Settings.backup

dosdev %SNAPDOS% %1%

robocopy "%DOCS_SRC%" "%DOCS_DST%" /MIR /B /R:0 /SEC >> "%LOGFILE%"

dosdev /D %SNAPDOS%


