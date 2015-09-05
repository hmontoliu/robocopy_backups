
Despliegue típico de backups por robocopy con y sin VSS
==============================================================================

Instalación
----------------------------

Crear un directorio ``c:\_backups\`` y copiar todo el contenido de esta carpeta en él. En caso de usar otra ruta modificar la variable ``RUNDIR`` de los scripts.

Rotación de backups
-------------------------

Los scripts powershell permiten la creación de respaldos rotatorios (ver variable `$ROTATEIDX` y cód. `lib_copias.ps1`)

Backups robocopy sin VSS
---------------------------------------------

Configurar tarea programada en windows y ejecutarla con los permisos del propio usuario al que se le hace el backup.

Batch
~~~~~~~~~~~

Para backups normales utilizar plantilla::

    documentsandoutlook.cmd

Powershell (recomendado)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Para backups normales utilizar la plantilla::

    documentsandoutlook.ps1

Para invocar como tarea programada recomiendo la siguiente sintaxis::

    powershell -ExecutionPolicy Bypass -Command "C:\_backups\documentsandoutlook.ps1"


Backups robocopy con VSS
---------------------------------------------

Batch
~~~~~~~~~~~~~~~~~


Para backups con VSS utilizar plantilla::

    vss_documentsandoutlook.cmd

Powershell (recomendado)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Para backups con VSS utilizar la plantilla::

    vss_documentsandoutlook.ps1

Para invocar como tarea programada recomiendo la siguiente sintaxis::

    powershell -ExecutionPolicy Bypass -Command "C:\_backups\vss_documentsandoutlook.ps1" "VSSBACKUP"



Modo de uso de los backups robocopy + VSS:

* Configurar las variables del script::

 * USUARIO
 * UNIDAD_SRC
 * SCRIPTNAME (si se cambia el nombre de la plantilla)


* Configurar tarea programada en windows y ejecutarla con privilegios elevados. El script requiere el parámetro "VSSBACKUP" para ejecutar el VSS(1):

  nombrescript VSSBACKUP

(1)  VSS requiere privilegios elevados (admin, backup operator y/o Performance Log Users) o bien que los binarios tengan esos privilegios (peligroso desde el punto de vista de la seguridad) 

Disclaimer
----------------------------------

This software is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE

.. vim:setlocal spell spelllang=es_es:ts=4:sw=4:et:ft=rst: 
