count_unique_active_traps_after_date <- function(data, cut_date) {
  data |>
    filter_by_date(cut_date) |>
    count_unique_active_traps()
}

count_unique_active_traps <- function(data) {
  data |>
    dplyr::filter(Trap_status == "A") |>
    dplyr::group_by(Type) |>
    dplyr::distinct(ID, .keep_all = TRUE) |>
    dplyr::summarise(count = dplyr::n())
}

filter_by_date <- function(data, cut_date, date_column = `Fecha`) {
  data |>
    dplyr::mutate({{ date_column }} := lubridate::ymd({{ date_column }})) |>
    dplyr::filter({{ date_column }} > lubridate::ymd(cut_date))
}
