add_latlon <- function(utm_coordinates, zone = 11) {
  lonlat <- oce::utm2lonlat(utm_coordinates$Coordenada_Este, utm_coordinates$Coordenada_Norte, zone = zone)
  utm_coordinates |> dplyr::mutate("latitude" = lonlat$latitude, "longitude" = lonlat$longitude)
}
