# base

FROM debian:bookworm-slim AS base

# Install packages, generate locales
ARG DEBIAN_FRONTEND=noninteractive
RUN set -eux; \
    apt-get update; \
    apt-get install --assume-yes --no-install-recommends --no-install-suggests \
        lib32gcc-s1=12.2.0-14 \
        lib32stdc++6=12.2.0-14 \
        ca-certificates=20230311 \
        locales=2.36-9+deb12u7 \
	gosu=1.14-1+b10; \
    rm -rf /var/lib/apt/lists/*


# s6-overlay

FROM busybox AS s6-overlay

ARG S6_OVERLAY_VERSION=3.2.0.0
ARG S6_OVERLAY_URL="https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}"

ADD "$S6_OVERLAY_URL/s6-overlay-noarch.tar.xz" /
ADD "$S6_OVERLAY_URL/s6-overlay-x86_64.tar.xz" /

RUN set -eux; \
    mkdir /s6-overlay; \
    tar -C /s6-overlay -Jxpf /s6-overlay-noarch.tar.xz; \
    tar -C /s6-overlay -Jxpf /s6-overlay-x86_64.tar.xz
    

# steamcmd

FROM busybox AS steamcmd

ARG STEAMCMD_URL="https://cdn.akamai.steamstatic.com/client/installer/steamcmd_linux.tar.gz"

ADD "$STEAMCMD_URL" /

RUN set -eux; \
    mkdir /steamcmd; \
    tar -C /steamcmd -zxpf /steamcmd_linux.tar.gz


# image

FROM base

RUN set -eux; \
    { \
        echo 'C.UTF-8 UTF-8'; \
	echo 'en_US.UTF-8 UTF-8'; \
    } > /etc/locale.gen; \
    locale-gen

RUN set -eux; \
    groupadd --system --gid='999' 'steam'; \
    useradd --create-home --system --uid='999' --gid='999' 'steam'

COPY --from=steamcmd /steamcmd/steamcmd.sh /steamcmd/linux32/steamcmd /usr/local/lib/steam/
COPY root/usr /usr

USER steam
RUN set -eux; \
    steamcmd +quit

USER root

COPY --from=s6-overlay --link /s6-overlay /
COPY root/etc /etc

ENTRYPOINT [ "/init" ]

ENV S6_CMD_ARG0="gosu steam"
