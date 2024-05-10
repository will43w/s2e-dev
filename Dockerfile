FROM ubuntu:22.04

# Install some basic command line tools we'll use later
RUN apt-get update
RUN apt-get -y install sudo
RUN sudo apt-get -y install -qq software-properties-common

# Add package source for python distributions - we need python < 3.12 for package `imp`
RUN sudo add-apt-repository -y ppa:deadsnakes/ppa
RUN sudo apt-get install -y python3.11
RUN sudo apt-get install -y git gcc cmake python3.11-dev python3.11-venv

RUN git clone https://github.com/s2e/s2e-env.git
RUN cd s2e-env

RUN python3.11 -m venv venv
RUN . venv/bin/activate
RUN pip install --upgrade pip wheel setuptools
RUN pip install .

ARG s2e-dev-path
VOLUME ${s2e-dev-path} /home/s2e-dev