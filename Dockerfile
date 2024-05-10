FROM ubuntu:22.04

# Install some basic command line tools we'll use later
RUN apt-get install
RUN sudo apt-get install software-properties-common

# Add package source for python distributions - we need python < 3.12 for package `imp`
RUN sudo add-apt-repository ppa:deadsnakes/ppa
RUN sudo apt-get install python3.11
RUN sudo apt-get install git gcc python3.11-dev python3.11-venv

RUN git clone https://github.com/s2e/s2e-env.git
RUN cd s2e-env

RUN python3.11 -m venv venv
RUN . venv/bin/activate
RUN pip install --upgrade pip wheel setuptools
RUN pip install .

# s2e won't run as root - create a non-root user
RUN useradd s2e-dev

# Open a shell as `s2e-dev` and reactivate the venv for s2e
RUN sudo -u s2e-dev bash
RUN . venv/bin/activate
