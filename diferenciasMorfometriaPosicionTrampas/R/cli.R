#' @export
write_traps_last_check <- function(options) {
  output_file <- options$output_path
  traps <- readr::read_csv(options$data_path, show_col_types = FALSE)
  traps |>
    last_active_trap() |>
    readr::write_csv(output_file)
}


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
