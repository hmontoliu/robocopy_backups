# Use a good editor like vim in GNU/Linux or notepad++ 

# variables generales (RUNDIR debe definirse en los scripts que llaman a este 

$RUNDIR = "C:\_backups\"
$TOOLSDIR = "${RUNDIR}\tools\"

# Opciones recomenadadas para robocopy 
$opts="/NP /MIR /R:1 /W:1 /XJ /FFT /TEE"

# /NP        - No mostrar el progreso (opcional)  
# /MIR       - Copia en espejo. Si no es necesario utilizar /E 
# /R:1 /W:1  - Tiempos de espera y reintento 
# /XJ        - Excludes junction points (W7 y sup) 
# /FFT       - two-second precision (útil al copiar a Samba-linux) 
# /TEE       - Mostar en pantalla cuando se usa /LOG  
# /MT        - Multitask (no usar en entornos sin recursos) 

# XP2003 o inferior necesitan windows resource kits 
# $rbcpy="C:\Archivos de programa\Windows Resource Kits\Tools\robocopy" 
# W7 o superior: 
$rbcpy="robocopy"

# loggin
$log_dir = "${RUNDIR}\logs"
$log_suf = "$((get-date).ToString('yyyy-dd-MM')).log"

# log_dir if not exists
New-Item -ItemType Directory -Force -Path $log_dir | Out-Null

# Variables y settings por defecto para los VSS-Robocopy scripts (opcional)
$VSCSC  = "${TOOLSDIR}\vscsc"
$DOSDEV = "${TOOLSDIR}\dosdev"
$UNIDAD_VSS = "B:"

# funciones
function rbackup([Parameter(Mandatory=$true)][string]$origen, 
                 [Parameter(Mandatory=$true)][string]$destino) {
	<#
	ejecuta: robocopy "$origen" "$destino" opciones /LOG+:logfile
	#>
	$cmd = '& {0} "{1}" "{2}" {3} /LOG+:{4}' -f $rbcpy, $origen, $destino, $opts, $logfile
	Invoke-Expression $cmd
	}
	
function rotatedest([Parameter(Mandatory=$true)][ValidateRange(1,7)][Int]$index) {
	<# rota el directorio de destino en funcion del factor de dia de la semana
    Ojo la tabla supone 1-7 Lun-Dom (py, linux), pero Windows usa 0-6 Dom-Sab. TODO!
	1 :  [(0, 'dom'), (0, 'jue'), (0, 'lun'), (0, 'mar'), (0, 'mie'), (0, 'sab'), (0, 'vie')]
    2 :  [(0, 'jue'), (0, 'mar'), (0, 'sab'), (1, 'dom'), (1, 'lun'), (1, 'mie'), (1, 'vie')]
    3 :  [(0, 'mie'), (0, 'sab'), (1, 'dom'), (1, 'jue'), (1, 'lun'), (2, 'mar'), (2, 'vie')]
    4 :  [(0, 'jue'), (1, 'lun'), (1, 'vie'), (2, 'mar'), (2, 'sab'), (3, 'dom'), (3, 'mie')]
    5 :  [(0, 'vie'), (1, 'lun'), (1, 'sab'), (2, 'dom'), (2, 'mar'), (3, 'mie'), (4, 'jue')]
    7 :  [(0, 'dom'), (1, 'lun'), (2, 'mar'), (3, 'mie'), (4, 'jue'), (5, 'vie'), (6, 'sab')]
	#>
    return [Int](get-date).DayOFWeek % $index
	}
