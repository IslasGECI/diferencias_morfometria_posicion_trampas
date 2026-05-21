datos_prueba <- readr::read_csv("/workdir/diferenciasMorfometriaPosicionTrampas/tests/data_tests/esfuerzo_data_tests.csv", show_col_types = FALSE)
datos_prueba_sin_capturas <- readr::read_csv("/workdir/diferenciasMorfometriaPosicionTrampas/tests/data_tests/esfuerzo_data_tests_sin_capturas.csv", show_col_types = FALSE)

describe("Que la función pase al formato tidy", {
  it("expected number of columns", {
    obtained <- effort_2_tidy(datos_prueba)
    obtained_columns <- colnames(obtained)
    expected_columns <- c("ID_de_trampa", "Estado_trampa", "Fecha", "Atrayente", "Nombre_del_responsable")
    expect_equal(obtained_columns, expected_columns)
  })
  it("expected number of rows", {
    obtained <- effort_2_tidy(datos_prueba)
    obtained_rows <- nrow(obtained)
    number_of_days <- 7
    number_of_traps <- nrow(datos_prueba)
    expected_rows <- number_of_days * number_of_traps
    expect_equal(obtained_rows, expected_rows)
  })
  it("expected output without captures", {
    expect_message(effort_2_tidy(datos_prueba_sin_capturas), "NO HAY CAPTURAS")
  })
})

describe("Function that check if columns exist in the data", {
  it("Column captures is missing", {
    df <- tibble::tibble(ID = 1:5, Atrayente = "Atrayente 1", Nombre_del_responsable = "Responsable 1")
    obtained <- check_columns_to_select(df)
    expected_columns <- c("ID", "Atrayente", "Nombre_del_responsable")
    expect_equal(obtained, expected_columns)
  })
  it("Data with column bycatch captures", {
    df <- tibble::tibble(ID = 1:5, Atrayente = "Atrayente 1", Nombre_del_responsable = "Responsable 1", Captura_incidental_de = "Garza", `2023-01-01` = "D")
    obtained <- check_columns_to_select(df)
    expected_columns <- c("ID", "Atrayente", "Nombre_del_responsable", "Captura_incidental_de")
    expect_equal(obtained, expected_columns)
  })
})
