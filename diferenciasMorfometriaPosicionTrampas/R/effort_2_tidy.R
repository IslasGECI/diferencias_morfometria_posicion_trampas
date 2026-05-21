#' @export
effort_2_tidy <- function(datos_prueba) {
  columns_to_select <- c("ID", "Atrayente", "Nombre_del_responsable")
  filter_table <-
    datos_prueba |> dplyr::select(columns_to_select, contains("/"))

  long_format <- filter_table |>
    tidyr::pivot_longer(cols = -columns_to_select, names_to = "Fecha", values_to = "Estado_trampa") |>
    dplyr::select(ID, Estado_trampa, Fecha, Atrayente, Nombre_del_responsable) |>
    dplyr::rename(ID_de_trampa = ID)

  rows_with_captures <- long_format |> filter_captures()
  if (nrow(rows_with_captures) == 0) {
    message("NO HAY CAPTURAS")
  }
  return(long_format)
}

get_existing_columns_to_select_in_df <- function(df) {
  all_columns_to_select <- c("ID", "Atrayente", "Nombre_del_responsable", "Captura_incidental_de")
  columns_in_df <- colnames(df)
  are_columns_in_df <- all_columns_to_select %in% columns_in_df
  all_columns_to_select[are_columns_in_df]
}
