# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- New function `get_existing_columns_to_select_in_df()`. Dynamically detects which of the expected columns (including `Captura_incidental_de`) exist in the input data frame.

### Fixed

### Changed

- `effort_2_tidy()` now supports the column `Captura_incidental_de` (bycatch captures). It uses `get_existing_columns_to_select_in_df()` to select only the columns that are present in the data, instead of a hardcoded set.

### Removed

## [1.4.0] - 2026-03-24
### Added
- CLI command `write_captures_from_tidy_positions`. Write to disk the captures marked as "X" or "RX" in the tidy format of position traps file.

## [1.3.0] - 2026-03-11
### Changed
- CLI command `write_tidy_traps_positions` now writes the column "Nombre_del_responsable".

## [1.2.0] - 2026-02-10
### Added
- CLI command `write_tidy_traps_positions` to write tidy format of position traps file.

## [1.0.1] - 2025-07-28
### Fixed
- Functions `convert_to_latlon()` and `convert_to_latlon_socorro()` does not drop UTM coordinates.

## [1.0.0] - 2025-07-01

### Removed

- Functions `write_traps_last_check()` and `write_type_of_traps()` by incompatibility with `trap_daily_status`.

### Changed

- Function `write_type_of_traps_by_id()` now expects date colum type as "Fecha".


## [0.4.0] - 2025-06-05

### Added

- Add function `write_type_of_traps_by_id()`. This function write the count of traps by position ID


## [0.3.0] - 2024-07-09

### Added

- Add function `write_cleaned_socorro_morphometry()`. This function clean the morphometry file for Socorro

## [0.2.0] - 2023-11-13

### Added

- Add functions `lower_columns_age_patron_and_status()` and `change_date_columns_to_geci_format()`.

## [0.1.3] - 2023-08-14

### Fixed

- Update recipe `clean`.
- Export function `effort_2_tidy()`.

## [0.1.2] - 2023-08-14

### Fixed

- Update recipe `install-r`.
- Export function `check_columns_name()`.

[Unreleased]: https://github.com/IslasGECI/diferencias_morfometrias_posicion_trampas/compare/v1.4.0...HEAD
[1.4.0]: https://github.com/IslasGECI/diferencias_morfometrias_posicion_trampas/compare/v1.3.0...v1.4.0
[1.3.0]: https://github.com/IslasGECI/diferencias_morfometrias_posicion_trampas/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/IslasGECI/diferencias_morfometrias_posicion_trampas/compare/v1.0.1...v1.2.0
[1.0.1]: https://github.com/IslasGECI/diferencias_morfometrias_posicion_trampas/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/IslasGECI/diferencias_morfometrias_posicion_trampas/compare/v0.4.0...v1.0.0
[0.4.0]: https://github.com/IslasGECI/diferencias_morfometrias_posicion_trampas/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/IslasGECI/diferencias_morfometrias_posicion_trampas/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/IslasGECI/diferencias_morfometrias_posicion_trampas/compare/v0.1.3...v0.2.0
[0.1.3]: https://github.com/IslasGECI/diferencias_morfometrias_posicion_trampas/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/IslasGECI/diferencias_morfometrias_posicion_trampas/compare/v0.1.1...v0.1.2
