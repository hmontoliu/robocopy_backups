Despliegue típico de backups por robocopy con y sin VSS
==============================================================================

Instalación
----------------------------

Crear un directorio ``c:\_backups\`` y copiar todo el contenido de esta carpeta en él.


Backups robocopy sin VSS
---------------------------------------------

Para backups normales utilizar plantilla::

    documentsandoutlook.cmd

Configurar tarea programada en windows y ejecutarla con los permisos del propio usuario al que se le hace el backup


Backups robocopy con VSS
---------------------------------------------


Para backups con VSS utilizar plantilla::

    vss_documentsandoutlook.cmd


Modo de uso de los backups robocopy + VSS:

* Configurar las variables del script::

 * USUARIO
 * UNIDAD_SRC
 * SRIPTNAME (si se cambia el nombre de la plantilla)


* Configurar tarea programada en windows y ejectutarla con privilegios elevados. El script requiere el parámetro "VSSBACKUP" para ejecutar el VSS:

  nombrescript VSSBACKUP

Disclaimer
----------------------------------

This software is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE
