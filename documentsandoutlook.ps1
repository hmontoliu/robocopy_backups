# Use a good editor like vim in GNU/Linux or notepad++ 
. C:\_backups\lib_copias.ps1

cd $RUNDIR

function rbackup($src, $dest) {
	<#
	Llama a: robocopy "origen" "destino" opciones /LOG+:logfile
	#>
	$cmd = '& {0} "{1}" "{2}" {3} /LOG+:{4}' -f $rbcpy, $src, $dest, $opts, $logfile
	Invoke-Expression $cmd
	}

$logfile="$log_dir\documentos_y_correo_$log_suf"
$destino="C:\copias_seguridad\${env:USERNAME}"

# Copia de perfil y correo típica para el usuario de W7 que ejecuta el script:
ForEach ($dir in "Desktop", "Documents", "Pictures", "Music")
{
	rbackup "${env:USERPROFILE}/${dir}" "${destino}/${dir}"
}

# otros archivos de outlook
rbackup "${env:USERPROFILE}\AppData\Local\Microsoft\Outlook" "${destino}\Outlook_Appdata"

# siempre respaldar el propio sistema de backup
rbackup "${rundir}" "${destino}\_backups"

# & shutdown -t 0 -f -s