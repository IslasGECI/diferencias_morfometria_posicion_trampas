#!/usr/bin/env bash

weekly_position_csv=${1}
files_path=$(dirname ${weekly_position_csv})
# Revisión estructural de la tabla posición trampa
# 1. Convertir archivos XLSX a CSV
    cutted_position_csv=${files_path}/cutted_position.csv
	source ./src/clean_position_morphometry.sh 
    cut_csv_file 11 ${weekly_position_csv} ${cutted_position_csv}


# 2. Encontrar duplicados
	echo "BUSCANDO DUPLICADOS"
    files_path=$(dirname ${weekly_position_csv})
    errors_directory=${files_path}/errores
    mkdir --parents ${errors_directory}
    src_path="src"
	weekly_position_basename=$(basename ${weekly_position_csv} .csv)
	${src_path}/distinct_position_traps ${cutted_position_csv} > ${errors_directory}/duplicados_${weekly_position_basename}

# 3. Revisar nombres de las columnas
	echo "REVISANDO EL ENCABEZADO"
	${src_path}/make_check_header.R --data ${cutted_position_csv}

# 3.1 Revisar intervalo de fechas
	python -m src.check_date_interval --input "${files_path}" --input "${weekly_position_basename}"

# 4. Validacion con datapackage
	#Cambiamos el encabezado del archivo CSV para correr en la carpeta 'validacion_datapackage' el goodtables
    datapackage_validation_file="posicion_trampas_gatos_ig.csv"
    dtp_src="data/validacion_datapackage"
	${src_path}/change_header ${cutted_position_csv} \
		> ${dtp_src}/${datapackage_validation_file}
	# Corre goodtables en la carpeta 'validacion_datapackage'
	echo "VERIFICACIÓN ESTRUCTURAL"
	goodtables ${dtp_src}/datapackage.json > ${errors_directory}/errores_estructurales_${weekly_position_basename}.txt

# Revisa y compara las capturas de los archivos posición trampas y morfometría gatos
# 5. Hacerlos tidy (feature/agrega_script_con_cli)
	echo "CONVIERTE TABLA A FORMATO TIDY Y CAMBIA FORMATO DE FECHA"
    tidy_position_csv=${files_path}/tidy_position.csv
	Rscript -e "diferenciasMorfometriaPosicionTrampas::write_tidy_traps_positions(diferenciasMorfometriaPosicionTrampas::get_domain_specific_options())" \
		--trap-positions-path ${weekly_position_csv} \
		--output-path ${tidy_position_csv} \
	&& cambia_formato_fecha ${tidy_position_csv} \
		> ${files_path}/ISO_tidy_positions.csv

