#!/usr/bin/env bash
#
# Función que cambia el encabezado del archivo de posición trampa para poder
# correr goodtables datapackage.json
folder_path=${1}
position_traps_data_file=${folder_path}/IG_POSICION_TRAMPAS_*.xlsx
morphometry_cats_data_file=${folder_path}/IG_MORFOMETRIA_GATOS_*.xlsx

src/demo_workflow ${position_traps_data_file} ${morphometry_cats_data_file}
