import subprocess
from bashtest import *
def test_show_diff_morphometry_position():
    bash_command = f"src/make_table_tidy.R --data tests/data/IG_POSICION_TRAMPAS_10MAY2020_correcto.csv --salida tests/data/prueba.csv"
    subprocess.getoutput(bash_command)
    file_new = "./tests/data/prueba.csv"
    file_test = "./tests/data_tests/tidy_data_test.csv"
    assert_equal_file(file_new, file_test)