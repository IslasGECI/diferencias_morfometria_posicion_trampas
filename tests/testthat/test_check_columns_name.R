library(tidyverse)
library(optparse)
library(diferenciasMorfometriaPosicionTrampas)
library(reshape2)

archivo_salida <- "../data_tests/column_name_data_test.csv"
salida_test <- tibble::as_tibble(readr::read_csv(archivo_salida))
archivo_prueba <- "../data/datos_formato_csv/IG_POSICION_TRAMPAS_10MAY2020.csv"
datos_prueba <- readr::read_csv(archivo_prueba)
obtained <- diferenciasMorfometriaPosicionTrampas::check_columns_name(datos_prueba)
nrow_obtained <- nrow(obtained)
nrow_expected <- 11
ncol_obtained <- ncol(obtained)
ncol_expected <- 2
type_obtained <- class(obtained)
type_expected <- class(salida_test)
first_column_type_obtained <- typeof(obtained[, 1])
first_column_type_expected <- typeof(salida_test[, 1])


test_that("Que el tipo sea el esperado", {
  expect_equal(type_expected, type_obtained)
  expect_equal(first_column_type_obtained, first_column_type_expected)
})

test_that("Que la forma sea la correcta", {
  expect_equal(nrow_expected, nrow_obtained)
  expect_equal(ncol_expected, ncol_obtained)
})

test_that("Detecte los nombres de las columnas que están incorrectas", {
  expect_equal(obtained, salida_test)
})
