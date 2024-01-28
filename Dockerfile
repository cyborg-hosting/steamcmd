ARG DEBIAN_FRONTEND=noninteractive

FROM debian:bookworm-slim

# Install, update & upgrade packages
ARG DEBIAN_FRONTEND
RUN set -o errexit && \
    set -o xtrace  && \
    apt-get update && \
    apt-get install --assume-yes --no-install-recommends --no-install-suggests \
        ca-certificates=20230311 \
        curl=7.88.1-10+deb12u5 \
        gosu=1.14-1+b6 \
        lib32gcc-s1=12.2.0-14 \
        lib32stdc++6=12.2.0-14 \
        locales=2.36-9+deb12u3 \
        vim-tiny=2:9.0.1378-2 && \
    rm -rf /var/lib/apt/lists/*

# Generate locales
ARG DEBIAN_FRONTEND
RUN set -o errexit && \
    set -o xtrace  && \
    echo 'C.UTF-8 UTF-8' >> /etc/locale.gen && \
    echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
    locale-gen

ADD --chown=root:root --chmod=755 docker-entrypoint.d/* /docker-entrypoint.d/
ADD --chown=root:root --chmod=755 docker-entrypoint.sh /docker-entrypoint.sh

ENV PUID=1000
ENV PGID=1000
ENV STEAMCMD_DIR=/steamcmd

ENTRYPOINT [ "/docker-entrypoint.sh" ]
