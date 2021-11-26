all: tests


define checkDirectories
if [ ! -d $(@D) ]; then mkdir --parents $(@D); fi
endef

# Reporte de densidades de cangrejos y lagartijas en Banco Chinchorro
# II. Declaración de las variables
# ===========================================================================
# Variables a resultados

xlsxIgPosicionTrampas10May2020 = \
	tests/data/datos_formato_excel/IG_POSICION_TRAMPAS_10MAY2020.xlsx

csvIgPosicionTrampas10May2020 = \
	tests/data/datos_formato_csv/IG_POSICION_TRAMPAS_10MAY2020.csv

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

$(csvMissingPosition): $(csvCleanedMorphometryCats) $(csvCleanedPositionTraps) src/show_diff_morphometry_position.R
	src/show_diff_morphometry_position.R \
		--data_1=reports/tables/cleaned_morphometry_cats.csv \
		--data_2=reports/tables/cleaned_position_traps.csv \
		>$@
$(csv_PosicionTrampasGatosDatapackage): $(csvIgPosicionTrampas10May2020) src/change_header
	mkdir --parents $(@D)
	src/change_header $< > $@

$(csvRepeatedDataTest): $(csvIgPosicionTrampas10May2020) src/distinct_position_traps
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
		linter \
		mutants \
		tests \
		tests_data

define lint
	pylint \
        --disable=bad-continuation \
        --disable=missing-class-docstring \
        --disable=missing-function-docstring \
        --disable=missing-module-docstring \
        ${1}
endef

check:
	black --check --line-length 100 ${module}
	black --check --line-length 100 src
	black --check --line-length 100 tests
	flake8 --max-line-length 100 ${module}
	flake8 --max-line-length 100 src
	flake8 --max-line-length 100 tests

clean:
	rm --force --recursive **/__pycache__
	rm --force --recursive data/raw/*ISO8601.csv
	rm --force --recursive data/validacion_datapackage/processed
	rm --force --recursive reports/tables
	rm --force --recursive tests/**/__pycache__
	rm --force *.tmp
	rm --force data/validacion_datapackage/*.csv
	rm --force diferenciasMorfometriaPosicionTrampas_1.0.tar.gz
	rm --force tests/data/*.csv
	rm --force tests/data/*.tmp
	rm --force tests/data/datos_formato_excel/*.csv

module = date_interval_tools
codecov_token = 17875b5e-e175-46f0-b473-ba3fcfe79c6e

coverage: install tests_data $(csvRepeatedDataTest)
	pytest --cov=${module} --cov-report=xml --verbose && \
	codecov --token=${codecov_token}

format:
	black --line-length 100 ${module}
	black --line-length 100 src
	black --line-length 100 tests
	R -e "library(styler)" \
	  -e "style_dir('diferenciasMorfometriaPosicionTrampas')" \
	  -e "style_dir('src')" \
	  -e "style_dir('tests')"

install:
	pip install .
	R CMD build diferenciasMorfometriaPosicionTrampas && \
	R CMD INSTALL diferenciasMorfometriaPosicionTrampas_0.1.1.tar.gz

linter:
	$(call lint, ${module})
	$(call lint, src)
	$(call lint, tests)

mutants: install tests_data $(csvRepeatedDataTest)
	mutmut run --paths-to-mutate ${module}

tests: install tests_data $(csvRepeatedDataTest)
	pytest --verbose tests/bashtest/
	pytest --verbose tests/pytest/
	R -e "testthat::test_dir('tests/testthat/', report = 'summary', stop_on_failure = TRUE)"

tests_data: $(csvIgPosicionTrampas10May2020)
	./src/distinct_position_traps $<
