describe("Test cli for write_type_of_traps", {
  it("Creates csv with type of traps", {
    data_path <- "/workdir/diferenciasMorfometriaPosicionTrampas/tests/data_tests/traps_daily_status_guadalupe.csv"
    output_path <- "/workdir/diferenciasMorfometriaPosicionTrampas/tests/number_of_traps_by_type.csv"
    date <- "2025-01-31"
    options <- list("data_path" = data_path, "initial_date" = date, "output_path" = output_path)
    testtools::if_exist_remove(output_path)
    write_type_of_traps(options)
    expect_true(testtools::exist_output_file(output_path))
    print(readr::read_csv(output_path))
    # testtools::if_exist_remove(output_path)  })
})

describe("Cli command for traps last check", {
  it("Write csv with traps last check", {
    data_path <- "/workdir/diferenciasMorfometriaPosicionTrampas/tests/data_tests/traps_daily_status_guadalupe.csv"
    output_path <- "/workdir/diferenciasMorfometriaPosicionTrampas/tests/active_traps.csv"
    options <- list("data_path" = data_path, "output_path" = output_path)
    testtools::if_exist_remove(output_path)
    write_traps_last_check(options)
    expect_true(testtools::exist_output_file(output_path))
    testtools::if_exist_remove(output_path)
  })
})
