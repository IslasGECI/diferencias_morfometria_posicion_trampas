.read_morphometry_file <- function(options) {
  input_file <- options$data_path
  morphometry <- readr::read_csv(input_file, show_col_types = FALSE)
}

.clean_morphometry <- function(morphometry_data, zone = 11) {
  morphometry_data |>
    dplyr::filter(Fecha > as.Date("2018-04-23")) |>
    lower_columns_age_patron_and_status() |>
    add_latlon(zone)
}
