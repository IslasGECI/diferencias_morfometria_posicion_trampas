import subprocess


def setup_xlsx_2_csv(type_data):
    bash_command = f"rm --force tests/data/datos_formato_excel/IG_{type_data}_12JUN2022.csv"
    subprocess.run(["bash", "-c", bash_command])


def test_clean_position():
    # Set up:
    type_data = "POSICION_TRAMPAS"
    setup_xlsx_2_csv(type_data)
    # Carga la función clean_position() desde el archivo clean_xlsx_2_csv.sh
    bash_command = "source src/clean_position_morphometry.sh && clean_position tests/data/datos_formato_excel/IG_POSICION_TRAMPAS_12JUN2022.xlsx"
    subprocess.run(["bash", "-c", bash_command])
    # Calcula el picadillo de la salida
    bash_command = "md5sum tests/data/datos_formato_excel/IG_POSICION_TRAMPAS_12JUN2022.csv"
    output = subprocess.getoutput(bash_command)
    obtained_md5 = output.split(" ")[0]
    expected_md5 = "4fd30809660722b7bef86b3216b00d30"
    assert obtained_md5 == expected_md5


def test_clean_morphometry():
    # Set up:
    type_data = "MORFOMETRIA_GATOS"
    setup_xlsx_2_csv(type_data)
    # Carga la función clean_position() desde el archivo clean_xlsx_2_csv.sh
    bash_command = "source src/clean_position_morphometry.sh && clean_morphometry tests/data/datos_formato_excel/IG_MORFOMETRIA_GATOS_12JUN2022.xlsx"
    subprocess.run(["bash", "-c", bash_command])
    # Calcula el picadillo de la salida
    bash_command = "md5sum tests/data/datos_formato_excel/IG_MORFOMETRIA_GATOS_12JUN2022.csv"
    output = subprocess.getoutput(bash_command)
    obtained_md5 = output.split(" ")[0]
    expected_md5 = "7cd3b0bd106d08eec93527b2bf3c9c85"
    assert obtained_md5 == expected_md5
