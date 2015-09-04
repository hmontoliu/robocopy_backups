# Use a good editor like vim in GNU/Linux or notepad++ 

# variables generales (RUNDIR debe definirse en los scripts que llaman a este 

$RUNDIR = "C:\_backups\"
$TOOLSDIR = "$RUNDIR\tools\"

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
$log_dir = "$RUNDIR\logs"
$log_suf = "$((get-date).ToString('yyyy-dd-MM')).log"

# log_dir if not exists
New-Item -ItemType Directory -Force -Path $log_dir | Out-Null



# Variables y settings por defecto para los VSS-Robocopy scripts (opcional)
$VSCSC  = "$TOOLSDIR\vscsc"
$DOSDEV = "TOOLSDIR\dosdev"
$UNIDAD_VSS="B:"


