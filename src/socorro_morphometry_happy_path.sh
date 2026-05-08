#!/usr/bin/env bash

cat_morphometry_file_name_xlsx=${1}
cat_morphometry_data_path=$(dirname ${cat_morphometry_file_name_xlsx})
cat_morphometry_file_name=$(basename ${cat_morphometry_file_name_xlsx} .xlsx)
cat_morphometry_data_file=${cat_morphometry_data_path}/${cat_morphometry_file_name}
# 6.1 Morfometría
# Convierte archivo de morfometría_gatos de xslx a csv
	echo "CONVIERTE ARCHIVO DE MORFOMETRIA DE XLSX A CSV"
	source ./src/clean_position_morphometry.sh 
    cut_socorro_morphometry ${cat_morphometry_file_name_xlsx} 
	row_number=$(wc -l < ${cat_morphometry_data_file}.csv)
	if [ $row_number -gt 1 ];
	then
	cambia_formato_fecha ${cat_morphometry_data_file}.csv \
		> ${cat_morphometry_data_file}_ISO8601.csv
	else 
	echo "NO HAY CAPTURAS"
	echo "🧐 El resultado de esta verificación los podemos ver a detalle en la carpeta \`errores\` que se genera dentro de nuestra carpeta de datos 🗃️"
	exit $?
	fi

# Tiene que ser la salida de la funcion cambia formato_fecha (ISO8601)
	echo "SELECCIONA CAPTURAS DEL ARCHIVO MORFOMETRÍA GATOS"
	Rscript -e "diferenciasMorfometriaPosicionTrampas::write_cleaned_socorro_morphometry(gecioptparse::get_options())" \
	--data_path=${cat_morphometry_data_file}_ISO8601.csv \
	--output_path=${cat_morphometry_data_path}/cleaned_morphometry_cats.csv

Rscript -e "diferenciasMorfometriaPosicionTrampas::write_morphometry_geci_format(gecioptparse::get_options())" \
	--data_path ${cat_morphometry_data_path}/cleaned_morphometry_cats.csv \
	--output_path ${cat_morphometry_data_path}/cleaned_morphometry_cats_geci_format.csv
