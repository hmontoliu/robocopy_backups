@echo off
:: Use a good editor like vim in GNU/Linux or notepad++ 

:: Opciones recomenadadas para robocopy 
set opts=/NP /MIR /R:1 /W:1 /XJ /FFT /TEE

:: /NP        - No mostrar el progreso (opcional)  
:: /MIR       - Copia en espejo. Si no es necesario utilizar /E 
:: /R:1 /W:1  - Tiempos de espera y reintento 
:: /XJ        - Excludes junction points (W7 y sup) 
:: /FFT       - two-second precision (útil al copiar a Samba-linux) 
:: /TEE       - Mostar en pantalla cuando se usa /LOG  
:: /MT        - Multitask (no usar en entornos sin recursos) 

:: W7 o superior: 
set rbcpy=robocopy

:: XP2003 o inferior necesitan windows resource kit 
:: set rbcpy="C:\Archivos de programa\Windows Resource Kits\Tools\robocopy" 

set log_dir=C:\_backups
set log_suf=%DATE:/=%.log

:: TODO if not exists
md %log_dir%





