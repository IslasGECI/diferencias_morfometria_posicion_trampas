filter_captures <- function(trap_status) {
  trap_status |> dplyr::filter(Estado_trampa == "X")
}
