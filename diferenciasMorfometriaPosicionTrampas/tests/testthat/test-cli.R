describe("Cli for transform UTM to latlon to Socorro", {
  utm_coordinates_path <- "/workdir/diferenciasMorfometriaPosicionTrampas/tests/data_tests/morphometry_socorro.csv"
  utm_coordinates <- readr::read_csv(utm_coordinates_path, show_col_types = FALSE)
  output_path <- "/workdir/diferenciasMorfometriaPosicionTrampas/tests/ids_in_latlon_socorro.csv"
  options <- list("data_path" = utm_coordinates_path, "output_path" = output_path)
  testtools::if_exist_remove(output_path)
  convert_to_latlon_socorro(options)
  it("convert_to_latlon_socorro()", {
    expect_true(testtools::exist_output_file(output_path))
    obtained_data <- readr::read_csv(output_path, show_col_types = FALSE)
    added_columns <- c("Coordenada_Este", "Coordenada_Norte")
    expect_true(all(!added_columns %in% colnames(obtained_data)))
  })
  it("check coordinates range", {
    max_lat <- 18.8599
    min_lat <- 18.7218
    max_lon <- -110.9173
    min_lon <- -111.0536
    obtained_data <- readr::read_csv(output_path, show_col_types = FALSE)
    expect_true(all(obtained_data$latitude < max_lat))
    expect_true(all(obtained_data$latitude > min_lat))
    expect_true(all(obtained_data$longitude < max_lon))
    expect_true(all(obtained_data$longitude > min_lon))
  })
  testtools::if_exist_remove(output_path)
})

describe("Test cli for write_type_of_traps_by_id", {
  it("Creates csv with type of traps", {
    data_path <- "/workdir/diferenciasMorfometriaPosicionTrampas/tests/data_tests/splited_trap_daily_status.csv"
    output_path <- "/workdir/diferenciasMorfometriaPosicionTrampas/tests/number_of_traps_by_type.csv"
    date <- "2025-02-01"
    options <- list("data_path" = data_path, "initial_date" = date, "output_path" = output_path)
    testtools::if_exist_remove(output_path)
    write_type_of_traps_by_id(options)
    expect_true(testtools::exist_output_file(output_path))
  })
})
describe("Test cli for write_type_of_traps", {
  it("Creates csv with type of traps", {
    data_path <- "/workdir/diferenciasMorfometriaPosicionTrampas/tests/data_tests/traps_daily_status_guadalupe.csv"
    output_path <- "/workdir/diferenciasMorfometriaPosicionTrampas/tests/number_of_traps_by_type.csv"
    date <- "2025-02-01"
    options <- list("data_path" = data_path, "initial_date" = date, "output_path" = output_path)
    testtools::if_exist_remove(output_path)
    write_type_of_traps(options)
    expect_true(testtools::exist_output_file(output_path))
    testtools::if_exist_remove(output_path)
  })
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
