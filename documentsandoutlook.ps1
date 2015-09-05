# Use a good editor like vim in GNU/Linux or notepad++ 
$COMMONSETTINGS = "C:\_backups\lib_copias.ps1"
. $COMMONSETTINGS
cd $RUNDIR

# Modificar si procede:
$LOGBASENAME = "documentos_y_correo"
$ROTATEIDX = 1 # 1 a 7
$DESTBASE="D:\copias_seguridad\${env:USERNAME}\"

# No Modificar
$logfile="${log_dir}\${LOGBASENAME}_${log_suf}"
$destprefix = "${DESTBASE}\" + (rotatedest ${ROTATEIDX}) + "\"

# Listado de elementos a respaldar
# ---------------------------------------------------
# uso:
#     rbackup "origen" "${destprefix}/destino"

# Copia de perfil y correo típica para el usuario de W7 que ejecuta el script:
ForEach ($dir in "Desktop", "Documents", "Pictures", "Music")
{
	rbackup "${env:USERPROFILE}/${dir}" "${destprefix}/${dir}"
}

# otros archivos de outlook
rbackup "${env:USERPROFILE}\AppData\Local\Microsoft\Outlook" "${destprefix}\Outlook_Appdata"

# siempre respaldar el propio sistema de backup
rbackup "${rundir}" "${destprefix}\_backups"

# & shutdown -t 0 -f -s