FROM ubuntu:latest

COPY --from=busybox:glibc /bin/busybox /bin/busybox

ARG COUNTRY=ja_JP
ARG ENCODE=UTF-8

ENV TZ=Asia/Tokyo
ENV PATH=/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/sbin:/usr/local/bin
ENV LANG=${COUNTRY}.${ENCODE}
ENV SHELL=/usr/bin/zsh
WORKDIR /root

RUN apt-get update && \
    apt-get install -y \
        build-essential \
        curl \
        git \
        locales \
        make \
        vim \
        xdg-user-dirs \
        zsh \
        && \
    rm -rf /var/lib/apt/lists/* && \
    for cmd in $(busybox --list) ; \
        do echo "#!/usr/bin/env bash\nbusybox ${cmd} \$@" > /usr/local/bin/${cmd} ; \
    done && \
    chmod +x /usr/local/bin/* && \
    ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo ${TZ} > /etc/timezone && \
    localedef -i ${COUNTRY} -c -f ${ENCODE} -A /usr/share/locale/locale.alias ${COUNTRY}.${ENCODE} && \
    LANG=C xdg-user-dirs-update
