import subprocess


def test_distinct_position_traps():
    assert_distinct_position_traps("tests/data/datos_formato_csv/IG_POSICION_TRAMPAS_10MAY2020.csv")


def assert_distinct_position_traps(file_input):
    bash_command = f"./src/distinct_position_traps {file_input} > tests/data/salida.tmp"
    subprocess.getoutput(bash_command)
    obtained_output = have_same_content("./tests/data/salida.tmp")
    expected_output = 0
    assert obtained_output == expected_output


def have_same_content(file_new):
    bash_command = f"diff {file_new} ./tests/data_tests/repeated_data_test.csv | wc --lines"
    output = int(subprocess.getoutput(bash_command))
    return output
