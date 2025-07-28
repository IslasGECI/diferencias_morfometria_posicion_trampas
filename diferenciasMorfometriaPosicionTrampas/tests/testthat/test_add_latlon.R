utm_coordinates_path <- "/workdir/diferenciasMorfometriaPosicionTrampas/tests/data_tests/morfometria_capitalized.csv"
utm_coordinates <- readr::read_csv(utm_coordinates_path, show_col_types = FALSE)
describe("Add latitude and longitude column", {
  it("Add latitude and longitude column", {
    obtained <- add_latlon(utm_coordinates)
    added_columns <- c("latitude", "longitude")
    expect_true(all(added_columns %in% colnames(obtained)))
    expected_latitude <- 29.038756
    expected_longitude <- -118.268294
    expect_equal(obtained$latitude[[7]], expected_latitude, tolerance = 1e-6)
    expect_equal(obtained$longitude[[7]], expected_longitude, tolerance = 1e-6)
  })
  it("Latitude and longitude for Socorro Island", {
    socorro_utm_coordinates <- tibble::tibble(
      "Coordenada_Este" = c(504841, 499684, 500966),
      "Coordenada_Norte" = c(2075051, 2084529, 2079174)
    )
    max_lat <- 18.8599
    min_lat <- 18.7218
    max_lon <- -110.9173
    min_lon <- -111.0536
    zone <- 12
    obtained <- add_latlon(socorro_utm_coordinates, zone)
    expect_true(all(obtained$latitude < max_lat))
    expect_true(all(obtained$latitude > min_lat))
    expect_true(all(obtained$longitude < max_lon))
    expect_true(all(obtained$longitude > min_lon))
  })
})
