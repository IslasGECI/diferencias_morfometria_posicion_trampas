# Selecciona únicamente las columnas ID, Coor-X, Coor-Y, Nombre_del_responsable y 
# fechas del archivo IG_POSICION_TRAMPAS_FECHA

data_file=${1}
table_name=$(basename "${data_file}" .xlsx)

csvcut --not-columns "12-13" ${data_file}
