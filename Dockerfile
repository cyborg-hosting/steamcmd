FROM debian:bookworm-slim AS dependency

# Install packages, generate locales
ARG DEBIAN_FRONTEND=noninteractive
RUN set -eux; \
    apt-get update; \
    apt-get install --assume-yes --no-install-recommends --no-install-suggests \
        ca-certificates=20230311 \
        curl=7.88.1-10+deb12u5 \
        gosu=1.14-1+b6 \
        lib32gcc-s1=12.2.0-14 \
        lib32stdc++6=12.2.0-14 \
        locales=2.36-9+deb12u7 \
        vim-tiny=2:9.0.1378-2; \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "/docker-entrypoint.sh" ]

FROM dependency AS dependency-check

ARG CACHEBUST=0

ARG DEBIAN_FRONTEND=noninteractive
RUN set -eux; \
    apt-get update; \
    if apt-get dist-upgrade --dry-run --quiet="2" | grep --regexp="^Inst"; then \
        exit 1; \
    fi; \
    rm -rf /var/lib/apt/lists/*

FROM dependency

RUN set -eux; \
    echo 'C.UTF-8 UTF-8' >> /etc/locale.gen; \
    echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen; \
    locale-gen

ADD --chown=root:root --chmod=755 docker-entrypoint.d /docker-entrypoint.d
ADD --chown=root:root --chmod=755 docker-entrypoint.sh /

ENV PUID=1000
ENV PGID=1000
ENV STEAMCMD_DIR=/steamcmd

