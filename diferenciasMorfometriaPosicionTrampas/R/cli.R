#' @export
write_type_of_traps_by_id <- function(options) {
  output_file <- options$output_path
  traps <- readr::read_csv(options$data_path, show_col_types = FALSE)
  traps |>
    count_unique_active_traps_after_date(options$initial_date) |>
    readr::write_csv(output_file)
}


#' @export
write_cleaned_morphometry <- function(options) {
  output_file <- options$output_path
  morphometry <- .read_morphometry_file(options)
  morphometry |>
    .clean_morphometry() |>
    readr::write_csv(output_file)
}

#' @export
write_cleaned_socorro_morphometry <- function(options) {
  output_file <- options$output_path
  morphometry <- .read_morphometry_file(options)
  morphometry |>
    .clean_morphometry(zone = 12) |>
    readr::write_csv(output_file)
}

#' @export
write_tidy_traps_positions <- function(options) {
  traps_positions <- readr::read_csv(options[["trap-positions-path"]], show_col_types = FALSE)
  traps_positions |>
    effort_2_tidy() |>
    readr::write_csv(options[["output-path"]])
}

#' @export
convert_to_latlon_socorro <- function(options) {
  utm_data <- readr::read_csv(options[["data_path"]], show_col_types = FALSE)
  utm_data |>
    add_latlon(zone = 12) |>
    readr::write_csv(options[["output_path"]])
}

#' @export
convert_to_latlon <- function(options) {
  utm_data <- readr::read_csv(options[["data_path"]], show_col_types = FALSE)
  utm_data |>
    add_latlon() |>
    readr::write_csv(options[["output_path"]])
}
