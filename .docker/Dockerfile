FROM archlinux:base-devel

COPY ./.docker/pkglist.txt /etc/pacman.d/pkglist.txt

ENV TZ=Asia/Tokyo

# The pacman-key and pacman -Syu commands must be run for the initial time with archlinux images.
RUN pacman-key --init && \
    pacman-key --populate archlinux && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    pacman -Syu --noconfirm && \
    pacman -S --needed  --noconfirm - < /etc/pacman.d/pkglist.txt

ENV SHELL=/usr/bin/zsh
WORKDIR /root

RUN xdg-user-dirs-update && \
    git clone https://github.com/yasunori0418/dotfiles.git
