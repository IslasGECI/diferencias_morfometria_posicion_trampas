all: tests


define checkDirectories
mkdir --parents $(@D)
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

$(csvCleanedMorphometryCats): data/raw/morfometria_gatos_erradicacion_isla_guadalupe_ISO8601.csv
	$(checkDirectories)
	Rscript -e "diferenciasMorfometriaPosicionTrampas::write_cleaned_morphometry(geci.optparse::get_options())" \
		--data_path=data/raw/morfometria_gatos_erradicacion_isla_guadalupe_ISO8601.csv \
		--output_path=$@

$(csvCleanedPositionTraps): $(csvPosicionTrampas) src/get_captures.R
	$(checkDirectories)
	src/get_captures.R \
		--data=$< \
		--out=$@

$(csvMissingPosition): $(csvCleanedMorphometryCats) $(csvCleanedPositionTraps)
	Rscript -e "diferenciasMorfometriaPosicionTrampas::write_diff_in_captures_between(geci.optparse::get_options())" \
		--left_data=reports/tables/cleaned_morphometry_cats.csv \
		--right_data=reports/tables/cleaned_position_traps.csv \
		--output_path=$@

$(csv_PosicionTrampasGatosDatapackage): $(csvIgPosicionTrampas10May2020) src/change_header
	$(checkDirectories)
	src/change_header $< > $@

$(csvRepeatedDataTest): $(csvIgPosicionTrampas10May2020) src/distinct_position_traps
	$(checkDirectories)
	src/distinct_position_traps $< > $@

$(csvMissingMorfometry): $(csvCleanedMorphometryCats) $(csvCleanedPositionTraps)
	Rscript -e "diferenciasMorfometriaPosicionTrampas::write_diff_in_captures_between(geci.optparse::get_options())" \
		--left_data=reports/tables/cleaned_position_traps.csv \
		--right_data=reports/tables/cleaned_morphometry_cats.csv \
		--output_path=$@


# V. Reglas del resto de los phonies
# ===========================================================================
.PHONY: \
		check \
		check_python \
		check_r \
		clean \
		coverage \
		format \
		green \
		green_spec \
		init \
		install \
		install_python \
		install_r \
		linter \
		mutants \
		red \
		red_spec \
		refactor \
		refactor_spec \
		setup \
		tests \
		tests_bash \
		tests_data \
		tests_python \
		tests_r

define lint
	pylint \
        --disable=bad-continuation \
        --disable=missing-class-docstring \
        --disable=missing-function-docstring \
        --disable=missing-module-docstring \
        ${1}
endef

check: check_r check_python

check_python:
	black --check --line-length 100 ${module}
	black --check --line-length 100 src
	black --check --line-length 100 tests
	flake8 --max-line-length 100 ${module}
	flake8 --max-line-length 100 src
	flake8 --max-line-length 100 tests

check_r:
	R -e "library(styler)" \
	  -e "resumen <- style_dir('diferenciasMorfometriaPosicionTrampas')" \
	  -e "resumen <- rbind(resumen, style_dir('src'))" \
	  -e "resumen <- rbind(resumen, style_dir('tests'))" \
	  -e "any(resumen[[2]])" \
	  | grep FALSE

clean:
	rm --force --recursive **/__pycache__
	rm --force --recursive data/raw/*ISO8601.csv
	rm --force --recursive data/validacion_datapackage/processed
	rm --force --recursive reports/tables
	rm --force --recursive tests/**/__pycache__
	rm --force .mutmut-cache
	rm --force *.tmp
	rm --force data/validacion_datapackage/*.csv
	rm --force diferenciasMorfometriaPosicionTrampas_*.tar.gz
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

init: setup tests

setup: init_github install
	shellspec --init

init_github:
	git config --global --add safe.directory /workdir
	git config --global user.name "Ciencia de Datos • GECI"
	git config --global user.email "ciencia.datos@islas.org.mx"

install: install_python install_r

install_python:
	pip install --editable .

install_r:
	cd diferenciasMorfometriaPosicionTrampas && \
	R -e "devtools::document()" && \
	R -e "devtools::check(error_on = 'error')" && \
	R -e "devtools::build()" && \
	R -e "devtools::install()"

linter:
	$(call lint, ${module})
	$(call lint, src)
	$(call lint, tests)

mutants: install tests_data $(csvRepeatedDataTest)
	mutmut run --paths-to-mutate ${module}

red: format
	Rscript -e "devtools::test('diferenciasMorfometriaPosicionTrampas', stop_on_failure = TRUE)" \
	&& git restore diferenciasMorfometriaPosicionTrampas/R/*.R \
	|| (git add diferenciasMorfometriaPosicionTrampas/tests/testthat/*.R && git commit -m "🛑🧪 Fail tests")
	chmod g+w -R .

green: format
	Rscript -e "devtools::test('diferenciasMorfometriaPosicionTrampas', stop_on_failure = TRUE)" \
	&& (git add diferenciasMorfometriaPosicionTrampas/R/*.R && git commit -m "✅ Pass tests") \
	|| git restore diferenciasMorfometriaPosicionTrampas/R/*.R
	chmod g+w -R .

refactor: format
	Rscript -e "devtools::test('diferenciasMorfometriaPosicionTrampas', stop_on_failure = TRUE)" \
	&& (git add diferenciasMorfometriaPosicionTrampas/R/*.R diferenciasMorfometriaPosicionTrampas/tests/testthat/*.R && git commit -m "♻️  Refactor $(message)") \
	|| git restore diferenciasMorfometriaPosicionTrampas/*.R
	chmod g+w -R .

red_spec: format
	shellspec \
	&& git restore spec/*spec.sh \
	|| (git add spec/*spec.sh && git commit -m "🛑🧪 Fail tests")
	chmod g+w -R .

green_spec: format
	shellspec \
	&& (git add src/*.sh && git commit -m "✅ Pass tests") \
	|| git restore src/*.sh
	chmod g+w -R .

refactor_spec: format
	shellspec \
	&& (git add src/*.sh spec/*spec.sh && git commit -m "♻️  Refactor") \
	|| git restore src/*.sh spec/*spec.sh
	chmod g+w -R .

tests: tests_data $(csvRepeatedDataTest) tests_bash tests_python tests_r tests_spec

tests_bash:
	pytest --verbose tests/bashtest/

tests_python:
	pytest --verbose tests/pytest/

tests_r:
	Rscript -e "devtools::test('diferenciasMorfometriaPosicionTrampas', stop_on_failure = TRUE)"

tests_data: $(csvIgPosicionTrampas10May2020)
	./src/distinct_position_traps $<

tests_spec:
	shellspec
