FROM ubuntu:latest

ARG COUNTRY=ja_JP
ARG ENCODE=UTF-8

ENV TZ=Asia/Tokyo
ENV PATH=/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/sbin:/usr/local/bin
ENV SHELL=/usr/bin/zsh
WORKDIR /root

COPY ./.docker/zonetime_Asia_Tokyo /etc/localtime

RUN apt-get update && \
    apt-get install -y \
        build-essential \
        libssl-dev \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        wget \
        llvm \
        libncurses5-dev \
        libncursesw5-dev \
        xz-utils \
        tk-dev \
        libffi-dev \
        liblzma-dev \
        curl \
        git \
        unzip \
        locales \
        make \
        vim \
        xdg-user-dirs \
        zsh \
        && \
    rm -rf /var/lib/apt/lists/* && \
    xdg-user-dirs-update && \
    sed -i "/${COUNTRY}.${ENCODE}/s/^# //g" /etc/locale.gen && \
    locale-gen

ENV LANG=${COUNTRY}.${ENCODE}
ENV LANGUAGE=${COUNTRY}:ja
ENV LC_ALL=${LANG}
