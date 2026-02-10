FROM islasgeci/base:latest
COPY . /workdir
RUN pip install \
        black \
        codecov \
        flake8 \
        mutmut==2.* \
        pylint \
        pytest \
        pytest-cov
RUN make install 
