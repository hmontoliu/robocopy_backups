
Despliegue típico de backups por robocopy con y sin VSS
==============================================================================

Instalación
----------------------------

Crear un directorio ``c:\_backups\`` y copiar todo el contenido de esta carpeta en él. En caso de usar otra ruta modificar la variable ``RUNDIR`` de los scripts.

Rotación de backups
-------------------------

Los scripts powershell permiten la creación de respaldos rotatorios (ver variable `$ROTATEIDX` y cód. `lib_copias.ps1`)

El `$ROTATEIDX` debe ser un valor entre 1 y 7. Un `$ROTATEIDX` de 1 implica una única copia que se sobreescribe cada día, uno de 7 implicaría una copia independiente para cada día de la semana. Ver todas las posibles combinaciones de rotación en la siguiente tabla::

    In [1]: dias = ['dom', 'lun', 'mar', 'mie', 'jue', 'vie', 'sab']
    In [2]: for i in range(1,8): print i, ': ', sorted([((dias.index(x))%i, x) for x in dias])
    1 :  [(0, 'dom'), (0, 'jue'), (0, 'lun'), (0, 'mar'), (0, 'mie'), (0, 'sab'), (0, 'vie')]
    2 :  [(0, 'dom'), (0, 'jue'), (0, 'mar'), (0, 'sab'), (1, 'lun'), (1, 'mie'), (1, 'vie')]
    3 :  [(0, 'dom'), (0, 'mie'), (0, 'sab'), (1, 'jue'), (1, 'lun'), (2, 'mar'), (2, 'vie')]
    4 :  [(0, 'dom'), (0, 'jue'), (1, 'lun'), (1, 'vie'), (2, 'mar'), (2, 'sab'), (3, 'mie')]
    5 :  [(0, 'dom'), (0, 'vie'), (1, 'lun'), (1, 'sab'), (2, 'mar'), (3, 'mie'), (4, 'jue')]
    6 :  [(0, 'dom'), (0, 'sab'), (1, 'lun'), (2, 'mar'), (3, 'mie'), (4, 'jue'), (5, 'vie')]
    7 :  [(0, 'dom'), (1, 'lun'), (2, 'mar'), (3, 'mie'), (4, 'jue'), (5, 'vie'), (6, 'sab')]

Backups robocopy sin VSS
---------------------------------------------

Configurar tarea programada en windows y ejecutarla con los permisos del propio usuario al que se le hace el backup.

Batch (obsoleto, se mantiene por compatibilidad con sistemas en uso)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

Batch (obsoleto, se mantiene por compatibilidad con sistemas en uso)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


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


* Configurar tarea programada en windows y ejecutarla con privilegios elevados. El script requiere el parámetro "VSSBACKUP" para ejecutar el VSS(1)::

    powershell -ExecutionPolicy Bypass -Command "C:\_backups\vss_documentsandoutlook.ps1" "VSSBACKUP"

(1)  VSS requiere privilegios elevados (admin, backup operator y/o Performance Log Users) o bien que los binarios tengan esos privilegios (peligroso desde el punto de vista de la seguridad) 

Disclaimer
----------------------------------

This software is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE

.. vim:setlocal spell spelllang=es_es:ts=4:sw=4:et:ft=rst: 
