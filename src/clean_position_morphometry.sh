#!/usr/bin/env bash
#
#Convierte archivo xlsx a csv

#set -euo pipefail



xlsx_2_csv(){
    data_file=${1}
    number_columns=${2}
    file_name=$(get_base_filename ${data_file})
    tmp_file_name=${file_name}.tmp
    in2csv --no-header-row --blanks ${data_file} | tail --lines=+2 > ${tmp_file_name}
    csv_file_name=${file_name}.csv
    cut_csv_file ${number_columns} ${tmp_file_name} ${csv_file_name}
}

get_base_filename(){
    data_file=${1}
    local src_path=$(dirname "${data_file}")
    table_name=$(basename "${data_file}" .xlsx)
    file_name=$src_path/$table_name
    echo $file_name
}

clean_position() {
    data_file=${1}
    number_columns=13
    cut_file ${data_file} ${number_columns}
}

clean_morphometry() {
    data_file=${1}
    number_columns=31
    cut_file ${data_file} ${number_columns}
}

cut_socorro_morphometry() {
    data_file=${1}
    number_columns=32
    cut_file ${data_file} ${number_columns}
}

cut_file() {
    data_file=${1}
    number_columns=${2}
    xlsx_2_csv ${data_file} ${number_columns}
}
    
cut_csv_file() {
    number_columns=${1}
    input_file_name=${2}
    output_file_name=${3}
    csvcut --columns 1-${number_columns} --delete-empty-rows ${input_file_name} > ${output_file_name}
}
