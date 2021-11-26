import subprocess


def test_select_needed_columns():
    assert_select_needed_columns("tests/data/datos_formato_csv/IG_POSICION_TRAMPAS_24OCT2021.csv")


def assert_select_needed_columns(file_input):
    bash_command = f"./src/select_needed_columns.sh {file_input} > tests/data/output.tmp"
    subprocess.getoutput(bash_command)
    output = have_same_content("./tests/data/output.tmp")
    assert output == 0


def have_same_content(file_new):
    bash_command = f"diff {file_new} tests/data/datos_formato_csv/IG_POSICION_TRAMPAS_24OCT2021_clean.csv | wc --lines"
    subprocess.getoutput(bash_command)
    return int(subprocess.getoutput(bash_command))
