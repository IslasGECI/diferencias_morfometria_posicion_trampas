datos_prueba <- readr::read_csv("/workdir/diferenciasMorfometriaPosicionTrampas/tests/data_tests/esfuerzo_data_tests.csv", show_col_types = FALSE)
datos_prueba_sin_capturas <- readr::read_csv("/workdir/diferenciasMorfometriaPosicionTrampas/tests/data_tests/esfuerzo_data_tests_sin_capturas.csv", show_col_types = FALSE)

describe("Que la función pase al formato tidy", {
  it("expected number of columns", {
    obtained <- xxeffort_2_tidy(datos_prueba)
    obtained_columns <- colnames(obtained)
    expected_columns <- c("ID_de_trampa", "Estado_trampa", "Fecha", "Atrayente", "Nombre_del_responsable")
    expect_equal(obtained_columns, expected_columns)
  })
  it("expected number of rows", {
    obtained <- xxeffort_2_tidy(datos_prueba)
    obtained_rows <- nrow(obtained)
    number_of_days <- 7
    number_of_traps <- nrow(datos_prueba)
    expected_rows <- number_of_days * number_of_traps
    expect_equal(obtained_rows, expected_rows)
  })
  it("expected output without captures", {
    expect_message(xxeffort_2_tidy(datos_prueba_sin_capturas), "NO HAY CAPTURAS")
  })
})
