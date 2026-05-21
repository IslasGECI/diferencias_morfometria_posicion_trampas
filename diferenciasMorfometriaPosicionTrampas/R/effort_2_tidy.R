#' @export
effort_2_tidy <- function(datos_prueba) {
  columns_to_select <- get_existing_columns_to_select_in_df(datos_prueba)
  filter_table <-
    datos_prueba |> dplyr::select(dplyr::all_of(columns_to_select), dplyr::contains("/"))

  long_format <- filter_table |>
    tidyr::pivot_longer(cols = -columns_to_select, names_to = "Fecha", values_to = "Estado_trampa")

  updated_columns_to_select <- c(columns_to_select, "Fecha", "Estado_trampa")
  long_format_selected <- long_format |>
    dplyr::select(dplyr::all_of(updated_columns_to_select)) |>
    dplyr::rename(ID_de_trampa = ID)

  rows_with_captures <- long_format_selected |> filter_captures()
  if (nrow(rows_with_captures) == 0) {
    message("NO HAY CAPTURAS")
  }
  return(long_format_selected)
}

get_existing_columns_to_select_in_df <- function(df) {
  all_columns_to_select <- c("ID", "Atrayente", "Nombre_del_responsable", "Captura_incidental_de")
  columns_in_df <- colnames(df)
  are_columns_in_df <- all_columns_to_select %in% columns_in_df
  all_columns_to_select[are_columns_in_df]
}
