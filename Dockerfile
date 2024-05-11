FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive 
ARG TZ=Europe/London

# Install some basic command line tools we'll use later
RUN apt-get update
RUN apt-get -y install sudo
RUN apt-get -y install -qq software-properties-common

# Add package source for python distributions - we need python < 3.12 for package `imp`
RUN add-apt-repository -y ppa:deadsnakes/ppa
RUN apt-get -y install -qq python3.11
RUN apt-get -y install -qq git gcc cmake python3.11-dev python3.11-venv

RUN git clone https://github.com/s2e/s2e-env.git
WORKDIR "/s2e-env"

RUN python3.11 -m ensurepip --upgrade
RUN python3.11 -m pip install --upgrade pip wheel setuptools
RUN python3.11 -m pip install .

# TODO: How to mount local dev files to image
ARG s2e-dev-path
VOLUME ${s2e-dev-path} /home/s2e-dev