FROM ubuntu:18.04

LABEL maintainer="João Galego <joao.galego@campus.ul.pt>"

ARG PYTHON3_VERSION=3.6.7-1~18.04
ARG PYTHON3_DEV_VERSION=$PYTHON3_VERSION
ARG PYTHON3_PIP_VERSION=9.0.1-2.3~ubuntu1.18.04.1
ARG PYTHON3_SETUPTOOLS_VERSION=39.0.1-2
ARG PYTHON3_WHEEL_VERSION=0.30.0-0.2

# Install dependencies
RUN apt-get update && \
    apt-get -y --no-install-recommends install python3="${PYTHON3_VERSION}" \
                                               python3-dev="${PYTHON3_DEV_VERSION}" \
                                               python3-pip="${PYTHON3_PIP_VERSION}" \
                                               python3-setuptools="${PYTHON3_SETUPTOOLS_VERSION}" \
                                               python3-wheel="${PYTHON3_WHEEL_VERSION}" && \
    apt-get clean \ && \
    rm -rf /var/lib/apt/lists/*

# Add tutorial files
COPY eeg_bci.ipynb /notebooks/
COPY requirements.txt /notebooks/

# Install python modules
WORKDIR /notebooks
RUN pip3 install -r requirements.txt

EXPOSE 8888

CMD [ "jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--notebook-dir=/notebooks", "--allow-root" ]