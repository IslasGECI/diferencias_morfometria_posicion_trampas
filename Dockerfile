FROM islasgeci/base:89e5
RUN R -e "install.packages(c('optparse'), repos = 'http://cran.rstudio.com')"
RUN pip install git+https://github.com/IslasGECI/descarga_datos.git@v0.1.0-beta
