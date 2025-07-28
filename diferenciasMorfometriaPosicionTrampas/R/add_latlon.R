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
    dplyr::select(-c("Coordenada_Este", "Coordenada_Norte")) |>
    readr::write_csv(options[["output_path"]])
}


add_latlon <- function(utm_coordinates, zone = 11) {
  lonlat <- oce::utm2lonlat(utm_coordinates$Coordenada_Este, utm_coordinates$Coordenada_Norte, zone = zone)
  utm_coordinates |> dplyr::mutate("latitude" = lonlat$latitude, "longitude" = lonlat$longitude)
}
