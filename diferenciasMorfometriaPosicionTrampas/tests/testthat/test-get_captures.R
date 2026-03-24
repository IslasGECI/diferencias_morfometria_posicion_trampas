describe("Filter captures", {
  trap_status <- readr::read_csv("/workdir/diferenciasMorfometriaPosicionTrampas/tests/data_tests/position_tidy_ISO.csv", show_col_types = FALSE)
  it("Filter captures as X", {
    obtained <- filter_captures(trap_status)
    expected_n_captures <- 3
    expect_equal(nrow(obtained), expected_n_captures)
  })
})
