import subprocess
from bashtest import assert_equal_file


def test_check_columns_name():
    set_check_columns_name()
    file_new = "./tests/data/check_header_test.csv"
    file_test = "./tests/data_tests/check_header_test.csv"
    assert_equal_file(file_new, file_test)


def set_check_columns_name():
    bash_command = "src/make_check_header.R --data tests/data/datos_formato_csv/IG_POSICION_TRAMPAS_10MAY2020.csv > tests/data/check_header_test.csv"
    subprocess.getoutput(bash_command)
