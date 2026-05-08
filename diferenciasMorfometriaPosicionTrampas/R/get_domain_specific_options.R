#' @export
get_domain_specific_options <- function(options) {
  data_path <- gecioptparse::character_option(c("-i", "--trap-positions-path"), default = "/workdir/reports/tables/input.csv", help = "File path of the desire input")
  output_path <- gecioptparse::character_option(c("-o", "--output-path"), default = "/workdir/reports/tables/result.csv", help = "File path of the desire output")
  option_names <- c(data_path, output_path)
  gecioptparse::get_options_from_vec(option_names)
}
