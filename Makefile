all: tests


define checkDirectories
if [ ! -d $(@D) ]; then mkdir --parents $(@D); fi
endef

# Reporte de densidades de cangrejos y lagartijas en Banco Chinchorro
# II. Declaración de las variables
# ===========================================================================
# Variables a resultados

xlsxIgPosicionTrampas10May2020 = \
	tests/data/IG_POSICION_TRAMPAS_10MAY2020.xlsx

csvIgPosicionTrampas10May2020 = \
	tests/data/IG_POSICION_TRAMPAS_10MAY2020.csv

csvRepeatedDataTest = \
	tests/data/repeated_data_test.csv

csv_PosicionTrampasGatosDatapackage = \
	data/validacion_datapackage/processed/posicion_trampas_gatos_ig.csv

csvMorfometriaGatos = \
	data/raw/morfometria_gatos_erradicacion_isla_guadalupe.csv

csvPosicionTrampas = \
	data/raw/posicion_trampas_gatos_isla_guadalupe.csv

csvMorfometriaGatosISO8601 = \
	data/raw/morfometria_gatos_erradicacion_isla_guadalupe_ISO8601.csv

csvCleanedPositionTraps = \
	reports/tables/cleaned_position_traps.csv

csvCleanedMorphometryCats = \
	reports/tables/cleaned_morphometry_cats.csv

csvMissingPosition = \
	reports/tables/missing_captures_in_position.csv

csvMissingMorfometry = \
	reports/tables/missing_captures_in_morfometry.csv

# III. Reglas para construir los objetivos principales
# ===========================================================================
# Objetivo para generar el README.pdf

# IV. Reglas para construir las dependencias de los objetivos principales
# ==========================================================================
$(csvMorfometriaGatos):
	if [ ! -d $(@D) ]; then mkdir --parents $(@D); fi
	descarga_datos $(@F) $(@D) morfometria_gatos_erradicacion_isla_guadalupe

$(csvPosicionTrampas):
	if [ ! -d $(@D) ]; then mkdir --parents $(@D); fi
	descarga_datos $(@F) $(@D) posicion_trampas_gatos_isla_guadalupe

$(csvMorfometriaGatosISO8601): $(csvMorfometriaGatos)
	$(checkDirectories)
	cambia_formato_fecha $< > $@

$(csvCleanedMorphometryCats): $(csvMorfometriaGatosISO8601) src/clean_morphometry.R
	if [ ! -d $(@D) ]; then mkdir --parents $(@D); fi
	src/clean_morphometry.R \
		--data=$< \
		--out=$@

$(csvCleanedPositionTraps): $(csvPosicionTrampas) src/get_captures.R
	mkdir --parents $(@D)
	src/get_captures.R \
		--data=$< \
		--out=$@

$(xlsxIgPosicionTrampas10May2020):
	if [ ! -d $(@D) ]; then mkdir --parents $(@D); fi
	descarga_datos $(@F) $(@D) excel/gatos_ig_data_test

$(csvMissingPosition): $(csvCleanedMorphometryCats) $(csvCleanedPositionTraps) src/show_diff_morphometry_position.R
	src/show_diff_morphometry_position.R \
		--data_1=reports/tables/cleaned_morphometry_cats.csv \
		--data_2=reports/tables/cleaned_position_traps.csv \
		>$@
$(csv_PosicionTrampasGatosDatapackage): $(csvIgPosicionTrampas10May2020) src/change_header
	mkdir --parents $(@D)
	src/change_header $< > $@

$(csvRepeatedDataTest): $(xlsxIgPosicionTrampas10May2020) src/distinct_position_traps
	mkdir --parents $(@D)
	src/distinct_position_traps $< > $@

$(csvMissingMorfometry): $(csvCleanedMorphometryCats) $(csvCleanedPositionTraps) src/show_diff_morphometry_position.R
	src/show_diff_morphometry_position.R \
		--data_1=reports/tables/cleaned_position_traps.csv \
		--data_2=reports/tables/cleaned_morphometry_cats.csv \
		>$@


# V. Reglas del resto de los phonies
# ===========================================================================
.PHONY: \
		check \
		clean \
		coverage \
		format \
		install \
		mutants \
		tests \
		tests_data

check:
	black --check --line-length 100 ${module}
	black --check --line-length 100 src
	black --check --line-length 100 tests

clean:
	rm --force --recursive data/raw
	rm --force --recursive data/validacion_datapackage/processed
	rm --force --recursive reports/tables
	rm --force --recursive tests/bashtest/__pycache__
	rm --force --recursive tests/pytest/__pycache__
	rm --force --recursive tests/__pycache__
	rm --force --recursive date_interval_tools/__pycache__
	rm --force *.tmp
	rm --force data/validacion_datapackage/*.csv
	rm --force diferenciasMorfometriaPosicionTrampas_1.0.tar.gz

module = date_interval_tools
codecov_token = 17875b5e-e175-46f0-b473-ba3fcfe79c6e

coverage: install
	pytest --cov=${module} --cov-report=xml --verbose && \
	codecov --token=${codecov_token}

format:
	R -e "library(styler)" \
	  -e "style_dir('diferenciasMorfometriaPosicionTrampas')" \
	  -e "style_dir('src')" \
	  -e "style_dir('tests')"
	black --line-length 100 \
		date_interval_tools \
		src \
		tests/bashtest \
		tests/pytest

install:
	pip install .
	R CMD build diferenciasMorfometriaPosicionTrampas && \
	R CMD INSTALL diferenciasMorfometriaPosicionTrampas_1.0.tar.gz

mutants:
	mutmut run --paths-to-mutate ${module}

tests: tests_data $(csvRepeatedDataTest)
	pytest --verbose tests/bashtest/
	R -e "testthat::test_dir('tests/testthat/', report = 'summary', stop_on_failure = TRUE)"
	pytest --verbose tests/pytest/

tests_data: $(xlsxIgPosicionTrampas10May2020)
	./src/distinct_position_traps $<
