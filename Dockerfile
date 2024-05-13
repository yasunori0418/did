FROM archlinux:base-devel

# Load package list file with variable.
ARG PKGLIST_FILE=./.docker/pkglist.txt

# You can specify a list of non-aur packages in text format.
# Adding package list.
COPY ${PKGLIST_FILE} /etc/pacman.d/${PKGLIST_FILE}

ARG COUNTRY=ja_JP
ARG ENCODE=UTF-8
ENV TZ=Asia/Tokyo
ENV SHELL=/usr/bin/zsh
WORKDIR /root

# The pacman-key and pacman -Syu commands must be run for the initial time with archlinux images.
RUN pacman-key --init && \
    pacman-key --populate archlinux && \
    pacman -Syu --noconfirm && \
    pacman -S --needed --noconfirm - < /etc/pacman.d/${PKGLIST_FILE} && \
    xdg-user-dirs-update && \
    ln -svf /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo "LANG=${COUNTRY}.${ENCODE}" > /etc/locale.conf

