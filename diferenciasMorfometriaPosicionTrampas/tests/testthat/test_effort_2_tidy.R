datos_prueba <- readr::read_csv("/workdir/diferenciasMorfometriaPosicionTrampas/tests/data_tests/esfuerzo_data_tests.csv", show_col_types = FALSE)
datos_prueba_2 <- readr::read_csv("/workdir/diferenciasMorfometriaPosicionTrampas/tests/data_tests/esfuerzo_data_tests_2.csv", show_col_types = FALSE)
datos_prueba_sin_capturas <- readr::read_csv("/workdir/diferenciasMorfometriaPosicionTrampas/tests/data_tests/esfuerzo_data_tests_sin_capturas.csv", show_col_types = FALSE)

describe("Que la función pase al formato tidy", {
  it("expected number of columns", {
    obtained <- xxeffort_2_tidy(datos_prueba)
    obtained_columns <- colnames(obtained)
    expected_columns <- c("ID_de_trampa", "Estado_trampa", "Fecha", "Atrayente")
    expect_equal(obtained_columns, expected_columns)
  })
  it("expected number of rows", {
    obtained <- effort_2_tidy(datos_prueba)
    obtained_rows <- nrow(obtained)
    expected_rows <- 42
    expect_equal(obtained_rows, expected_rows)
  })
  it("expected second output", {
    salida_test_2 <- data.frame(
      ID_de_trampa = factor(rep(c("TC-20-1084", "TC-20-1085", "TC-10-0980-MV"), each = 7)),
      Estado_trampa = factor(c("A", "A", "X", "A", "A", "A", "A", "A", "A", "X", "A", "A", "A", "A", "X", "A", "A", "A", "A", "D", "D")),
      Fecha = factor(rep(c("4/27/2020", "4/28/2020", "4/29/2020", "4/30/2020", "5/1/2020", "5/2/2020", "5/3/2020"), 3))
    )
    obtained <- effort_2_tidy(datos_prueba_2)
    expect_equal(obtained, salida_test_2)
  })
  it("expected output without captures", {
    salida_test_sin_capturas <- data.frame(
      ID_de_trampa = factor(rep(c("TC-10-0963-MP", "TC-10-0981-MV"), each = 7)),
      Estado_trampa = factor(c("A", "A", "A", "A", "A", "D", "D", "A", "A", "A", "A", "A", "D", "D")),
      Fecha = factor(rep(c("4/27/2020", "4/28/2020", "4/29/2020", "4/30/2020", "5/1/2020", "5/2/2020", "5/3/2020"), 2))
    )
    obtained <- effort_2_tidy(datos_prueba_sin_capturas)
    expect_equal(obtained, salida_test_sin_capturas)
    expect_message(effort_2_tidy(datos_prueba_sin_capturas), "NO HAY CAPTURAS")
  })
})
