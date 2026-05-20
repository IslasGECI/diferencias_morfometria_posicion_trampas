#!/usr/bin/env bash
#
#Convierte archivo xlsx a csv

#set -euo pipefail



xlsx_2_csv(){
    data_file=${1}
    file_name=${2}
    tmp_file_name=${file_name}.tmp
    in2csv --no-header-row --blanks ${data_file} | tail --lines=+2 > ${tmp_file_name}
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
    cut_file ${data_file}
}

clean_morphometry() {
    data_file=${1}
    cut_file ${data_file}
}

cut_socorro_morphometry() {
    data_file=${1}
    cut_file ${data_file}
}

cut_file() {
    data_file=${1}
    file_name=$(get_base_filename ${data_file})
    xlsx_2_csv ${data_file} ${file_name}
    tmp_file_name=${file_name}.tmp
    number_columns=$(count_columns ${tmp_file_name})
    csv_file_name=${file_name}.csv
    cut_csv_file ${number_columns} ${tmp_file_name} ${csv_file_name}
}
    
count_columns() { csvcut -n ${1} | grep -c ": ." ; }

cut_csv_file() {
    number_columns=${1}
    input_file_name=${2}
    output_file_name=${3}
    csvcut --columns 1-${number_columns} --delete-empty-rows ${input_file_name} > ${output_file_name}
}
