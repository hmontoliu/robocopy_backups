. C:\_backups\lib_copias.ps1

cd $RUNDIR

$logfile="$log_dir\documentos_y_correo_$log_suf"
$destino="C:\copias_seguridad\${env:USERNAME}"

# Copia de perfil y correo típica para el usuario de W7 que ejecuta el script:
ForEach ($dir in "Desktop", "Documents", "Pictures", "Music")
{
	$src, $dest = "${env:USERPROFILE}/${dir}", "${destino}/${dir}"
	$cmd = '& {0} "{1}" "{2}" {3} /LOG+:{4}' -f $rbcpy, $src, $dest, $opts, $logfile 
	Invoke-Expression $cmd
}

# otros archivos de outlook
$src = "${env:USERPROFILE}\AppData\Local\Microsoft\Outlook" 
$dest = "${destino}\Outlook_Appdata"
$cmd = '& {0} "{1}" "{2}" {3} /LOG+:{4}' -f $rbcpy, $src, $dest, $opts, $logfile
Invoke-Expression $cmd

# siempre respaldar el propio sistema de backup
#%rbcpy% %RUNDIR% %destino%\_backups %opts% /LOG+:%logfile%
$dest = "$destino\_backups"
$cmd = '& {0} "{1}" "{2}" {3} /LOG+:{4}' -f $rbcpy, $rundir, $dest, $opts, $logfile
Invoke-Expression $cmd

# & shutdown -t 0 -f -s
#exit /b 0