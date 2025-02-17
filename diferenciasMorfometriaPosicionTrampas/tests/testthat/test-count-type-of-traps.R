assert_type_count <- function(data, trap_type, expected_number) {
  obtained_number <- data |>
    dplyr::filter(type == trap_type) |>
    dplyr::pull(count)
  expect_equal(obtained_number, expected_number)
}
describe("🪙 Count active traps by type on certain period", {
  data <- tibble::tibble(
    "ID_de_trampa" = c("TC-01-001-NA", "TP-01-001-NA", "TC-02-002-NA"),
    "Estado_trampa" = "A",
    "Fecha" = c("2025-01-01", "2025-01-31", "2025-01-31"),
  )
  cut_date <- "2025-01-15"
  it("count_active_traps_after_date()", {
    obtained <- count_active_traps_after_date(data, cut_date)
    expected_number_of_TC <- 1
    assert_type_count(obtained, "TC", expected_number_of_TC)
  })
  it("filter by date", {
    obtained <- filter_by_date(data, cut_date)
    expected_number_of_rows <- 2
    obtained_number_of_rows <- nrow(obtained)
    expect_equal(obtained_number_of_rows, expected_number_of_rows)
  })
})
describe("Count active traps by type", {
  data <- tibble::tibble(
    "ID_de_trampa" = c("TC-01-001-NA", "TC-01-001-NA", "TP-01-001-NA", "TC-02-002-NA"),
    "Estado_trampa" = "A",
    "Fecha" = c("2025-01-31", "2025-02-01", "2025-01-31", "2025-01-31"),
  )
  obtained <- count_active_traps(data)

  data_2 <- tibble::tibble(
    "ID_de_trampa" = c("TC-01-001-NA", "TP-01-001-NA", "TP-02-002-NA"),
    "Estado_trampa" = c("A", "D", "A"),
    "Fecha" = c("2025-01-31", "2025-01-31", "2025-01-31"),
  )
  obtained_2 <- count_active_traps(data_2)
  it("count_active_traps(): type TC", {
    expected_number_of_TC <- 2
    assert_type_count(obtained, "TC", expected_number_of_TC)

    expected_number_of_TC <- 1
    assert_type_count(obtained_2, "TC", expected_number_of_TC)
  })
  it("count_active_traps(): type TP", {
    expected_number_of_TP <- 1
    assert_type_count(obtained, "TP", expected_number_of_TP)

    assert_type_count(obtained_2, "TP", expected_number_of_TP)
  })
})
describe("add_type_column()", {
  it("data 1", {
    data <- tibble::tibble(
      "ID_de_trampa" = c("TC-01-001-NA", "TP-01-001-NA", "TC-02-002-NA"),
      "Estado_trampa" = "A",
      "Fecha" = c("2025-01-31", "2025-01-31", "2025-01-31"),
    )
    obtained <- .add_type_column(data)
    expected <- tibble::tibble(
      "ID_de_trampa" = c("TC-01-001-NA", "TP-01-001-NA", "TC-02-002-NA"),
      "Estado_trampa" = "A",
      "Fecha" = c("2025-01-31", "2025-01-31", "2025-01-31"),
      "type" = c("TC", "TP", "TC")
    )
    expect_equal(obtained, expected)
  })
})
