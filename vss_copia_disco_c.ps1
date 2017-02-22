# VSS requiere privilegios elevados (admin, backup operator y/o Performance Log
# Users) o bien que los binarios tengan privilegios (peligroso)
# basado en http://vscsc.sourceforge.net/
$COMMONSETTINGS = "C:\_backups\lib_copias.ps1"
. $COMMONSETTINGS
cd $RUNDIR

# Modificar si procede
$USUARIO = "user"  # nombre del usuario a respaldar (${env:USERNAME} si es admin)
$UNIDAD="C"        # nombre de la unidad en la que se hará la instantánea
$UNIDAD_SRC = "${UNIDAD}:" # (por compatibilidad)
$ROTATEIDX = 1 # 1 a 7
$DESTBASE="Z:\backups\${USUARIO}\" # local 
#$DESTBASE="Z:\backups\${UNIDAD}"          # local
#$DESTBASE="\\backupserver\path\${UNIDAD}" # remoto
$LOGBASENAME = "vss_copia_disco_${UNIDAD}"
$VSSUSERPROFILE = "${UNIDAD_VSS}\users\${USUARIO}"  # TODO: automatizar

# No Modificar
$logfile="${log_dir}\${LOGBASENAME}_${log_suf}"
$destprefix = "${DESTBASE}\" + (rotatedest ${ROTATEIDX}) + "\"
$scriptname = $MyInvocation.MyCommand.Name

# opcional, no empezar el backup si el servidor no está disponible (portátiles)
# servidor remoto
# SERVER=10.0.0.10
# if(Test-Connection -Cn ${SERVER} -BufferSize 16 -Count 1 -ea 0 -quiet) {

if ($ARGS[0] -eq "VSSBACKUP") {

	# horrible hack, pido disculpas :-(
	$tmpcmd = 'powershell -ExecutionPolicy Bypass -Command "{0}\{1}" "%1%"' -f $rundir, $scriptname
	Set-Content $rundir/callscript.cmd "$tmpcmd" -Encoding ASCII
	$vsscmd = '& {0} -exec={1}\callscript.cmd {2} ' -f $VSCSC, $rundir, $UNIDAD_SRC
	Invoke-Expression $vsscmd
   
	} ELSE {

	$thiscmd = '& {0} {1} {2}' -f ${DOSDEV}, ${UNIDAD_VSS}, $ARGS[0]
	Invoke-Expression $thiscmd
		
	# Listado de elementos a respaldar
	# ---------------------------------------------------
	# uso:
	#     rbackup "origen" "${destprefix}/destino"

	# Copia de perfil y correo típica para el usuario de W7 que ejecuta el script:
	ForEach ($dir in "Desktop", "Documents", "Pictures", "Music")
	{
	  rbackup "${VSSUSERPROFILE}/${dir}" "${destprefix}/${dir}"
	}

	# otros archivos de outlook
	rbackup "${VSSUSERPROFILE}\AppData\Local\Microsoft\Outlook" "${destprefix}\Outlook_Appdata"

    # otros directorios a respaldar en la unidad en la que se hace el vss
    # rbackup "${UNIDAD_VSS}\path1" "${destprefix}\path1" 
    # rbackup "${UNIDAD_VSS}\path2" "${destprefix}\path2" 
    # ...

	# siempre respaldar el propio sistema de backup fuera del vss
	rbackup "${rundir}" "${destprefix}\_backups"

} 

# } # /if Test-Connection ...
#
# shutdown at the end
# Stop-Computer -ComputerName localhost -Force
