#' @export
effort_2_tidy <- function(datos_prueba) {
  filter_table <-
    datos_prueba |> dplyr::select(c("ID", "Nombre_del_responsable", (length(datos_prueba) - 6):(length(datos_prueba)) - 2), length(datos_prueba))

  long_format <- filter_table |>
    tidyr::pivot_longer(cols = -c(ID, Atrayente, Nombre_del_responsable), names_to = "Fecha", values_to = "Estado_trampa") |>
    dplyr::select(ID_de_trampa = ID, Estado_trampa, Fecha, Atrayente, Nombre_del_responsable)

  rows_with_captures <- dplyr::filter(long_format, Estado_trampa == "X")
  if (nrow(rows_with_captures) == 0) {
    message("NO HAY CAPTURAS")
  }
  return(long_format)
}
