#!/usr/bin/env Rscript
#
#

library(tidyverse)
library(optparse)
library(diferenciasMorfometriaPosicionTrampas)
library(reshape2)

# Sección de la CLI
option_list <- list(
  make_option(
    c("-d", "--data"),
    default = NULL,
    help = "nombre del archivo de entrada",
    metavar = "character",
    type = "character"
  )
)
opt_parser <- OptionParser(option_list = option_list)
options <- parse_args(opt_parser)
input_file <- options$data
data <- readr::read_csv(input_file)
table <- diferenciasMorfometriaPosicionTrampas::check_columns_name(data)
if (all(table$es_correcto)) {
  print("LA CABECERA ES CORRECTA")
} else {
  print(table)
}
