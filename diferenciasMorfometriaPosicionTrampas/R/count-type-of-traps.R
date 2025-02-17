count_active_traps_after_date <- function(data, cut_date) {
  data |>
    filter_by_date(cut_date) |>
    count_active_traps()
}


count_active_traps <- function(data) {
  data |>
    .add_type_column() |>
    .count_actived_traps_by_type()
}

.add_type_column <- function(data) {
  data |> dplyr::mutate(type = stringr::str_sub(ID_de_trampa, 1, 2))
}

.count_actived_traps_by_type <- function(data) {
  data |>
    dplyr::filter(Estado_trampa == "A") |>
    dplyr::distinct(ID_de_trampa, .keep_all = TRUE) |>
    dplyr::group_by(type) |>
    dplyr::summarise(count = dplyr::n())
}

filter_by_date <- function(data, cut_date) {
  data |>
    dplyr::filter(Fecha > cut_date)
}
