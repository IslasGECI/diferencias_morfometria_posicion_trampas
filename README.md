# Detección de errores

Programa para detectar errores en las bases de datos de posición trampas y mofometría de gatos en
isla Guadalupe

```
git clone https://bitbucket.org/IslasGECI/diferencias_morfometria_posicion_trampas.git
cd diferencias_morfometria_posicion_trampas
make --makefile=build/Makefile build
sudo make --makefile=build/Makefile install
```

Para para poder verificar los datos de `IG_POSICION_TRAMPAS_FECHA.XLSX` y los de
`IG_MORFOMETRIA_GATOS_FECHA.XLSX`, es necesario tenerlos juntos en una carpeta; es decir, solo debe
de estar el par de archivos de la fecha que estemos revisando.

Correremos los datos de la siguiente forma:
```shell
./src/verify_data.sh data_folder
```
Por ejemplo para los datos que se encuentran dentro del folder `tests/data/IG_DATOS_GATOS_21NOV2021`
corremos:
```shell
./src/verify_data.sh tests/data/IG_DATOS_GATOS_21NOV2021
```

El resultado de esta verificación los podemos ver a detalle en la carpeta `errores` que se genera
dentro de nuestra carpeta de datos.

Para limpiar la carpeta de los datos corremos la siguiente instrucción:
```shell
./src/clean_output_data data_folder
```
Por ejemplo, para nuestros datos de prueba:
```shell
./src/clean_output_data tests/data/IG_DATOS_GATOS_21NOV2021
```