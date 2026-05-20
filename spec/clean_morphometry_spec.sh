#shellcheck shell=sh

Describe 'clean raw files'
  Include /workdir/src/clean_position_morphometry.sh
  checksum() { md5sum ${output} | cut -d " " -f1; }
  clean_output() { rm --force ${output};}
  count_columns_from_file() { csvcut -n ${output} | wc -l; }
  count_rows() { cat ${output} | wc -l; }
  BeforeEach 'clean_output'
  AfterEach 'clean_output'
  It 'cut socorro morphometry'
    output="/workdir/tests/data/datos_formato_excel/IS_MORFOMETRIA_GATOS_JUN2024.csv"
    target="/workdir/tests/data/datos_formato_excel/IS_MORFOMETRIA_GATOS_JUN2024.xlsx"
    When call cut_socorro_morphometry ${target}
    The result of function count_columns_from_file should eq 32
  End
  It 'clean morphometry'
    output="/workdir/tests/data/datos_formato_excel/IG_MORFOMETRIA_GATOS_12JUN2022.csv"
    target="/workdir/tests/data/datos_formato_excel/IG_MORFOMETRIA_GATOS_12JUN2022.xlsx"
    When call clean_morphometry ${target}
    The result of function count_columns_from_file should eq 31
    The result of function count_rows should eq 3
  End
  It 'clean position'
    output="/workdir/tests/data/datos_formato_excel/IG_POSICION_TRAMPAS_12JUN2022.csv"
    target="/workdir/tests/data/datos_formato_excel/IG_POSICION_TRAMPAS_12JUN2022.xlsx"
    When call clean_position ${target}
    The result of function count_columns_from_file should eq 13
    The result of function count_rows should eq 1639
  End
End
