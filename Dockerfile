FROM python:3-slim

ENV DEBIAN_FRONTEND noninteractive

###################################
### MoviePy section starts here ###
###################################

# For moviepy https://github.com/Zulko/moviepy/blob/master/Dockerfile
## Install numpy using system package manager
RUN echo 'deb http://ftp.de.debian.org/debian stretch main contrib' >> '/etc/apt/sources.list'
RUN apt-get -y update && apt-get -y install apt-utils
RUN apt-get -y install git libav-tools imagemagick libopencv-dev python-opencv

## Install some special fonts we use in testing, etc..
RUN apt-get -y install fonts-liberation fonts-lato

RUN apt-get -y install ttf-mscorefonts-installer

RUN apt-get install -y locales && \

    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8

ENV LC_ALL C.UTF-8

## modify ImageMagick policy file so that Textclips work correctly.
RUN cat /etc/ImageMagick-6/policy.xml | sed 's/none/read,write/g'> /etc/ImageMagick-6/policy.xml