assert_type_count <- function(data, trap_type, expected_number) {
  obtained_number <- data |>
    dplyr::filter(type == trap_type) |>
    dplyr::pull(count)
  expect_equal(obtained_number, expected_number)
}
assert_unique_type_count <- function(data, trap_type, expected_number) {
  obtained_number <- data |>
    dplyr::filter(Type == trap_type) |>
    dplyr::pull(count)
  expect_equal(obtained_number, expected_number)
}
describe("Count unique active traps by type", {
  data <- tibble::tibble(
    "Fecha" = c("2025-01-31", "2025-02-01", "2025-01-31"),
    "Type" = c("TC", "TP", "TC"),
    "ID" = c("01-001", "01-001", "02-002"),
    "Trapper" = c("NA", "NA", "NA"),
    "Trap_status" = "A",
  )
  cut_date <- "2025-01-31"
  it("count_unique_active_traps_after_date()", {
    obtained <- count_unique_active_traps_after_date(data, cut_date)
    expected_number_of_TP <- 1
    assert_unique_type_count(obtained, "TP", expected_number_of_TP)
  })
  it("count_unique_active_traps()", {
    obtained <- count_unique_active_traps(data)
    expected_number_of_TC <- 2
    assert_unique_type_count(obtained, "TC", expected_number_of_TC)

    expected_number_of_TP <- 1
    assert_unique_type_count(obtained, "TP", expected_number_of_TP)
  })
})
