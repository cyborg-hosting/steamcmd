#!/bin/sh

set -eu

if [ ! -f "${STEAMCMD_DIR}/steamcmd.sh" ]; then
    curl --fail --silent --show-error --location "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar --extract --gzip --file=- --directory="${STEAMCMD_DIR}"
fi

if [ ! -e "${STEAMCMD_DIR}/steamservice.so" ]; then
    ln --force --symbolic "${STEAMCMD_DIR}/linux32/steamclient.so" "${STEAMCMD_DIR}/steamservice.so"
fi

if [ ! -e "${STEAMCMD_DIR}/steam.sh" ]; then
    ln --force --symbolic "${STEAMCMD_DIR}/steamcmd.sh" "${STEAMCMD_DIR}/steam.sh"
fi

mkdir --parents "${HOME}/.steam/sdk32"
if [ ! -e "${HOME}/.steam/sdk32/steamclient.so" ]; then
    ln --force --symbolic "${STEAMCMD_DIR}/linux32/steamclient.so" "${HOME}/.steam/sdk32/steamclient.so"
fi

mkdir --parents "${HOME}/.steam/sdk64"
if [ ! -e "${HOME}/.steam/sdk64/steamclient.so" ]; then
    ln --force --symbolic "${STEAMCMD_DIR}/linux64/steamclient.so" "${HOME}/.steam/sdk64/steamclient.so"
fi

mkdir --parents "${STEAMCMD_DIR}/linux64"
if [ ! -e "${STEAMCMD_DIR}/linux64/steamservice.so" ]; then
    ln --force --symbolic "${STEAMCMD_DIR}/linux64/steamclient.so" "${STEAMCMD_DIR}/linux64/steamservice.so"
fi
if [ ! -e "${STEAMCMD_DIR}/linux64/steam" ]; then
    ln --force --symbolic "${STEAMCMD_DIR}/linux64/steamcmd" "${STEAMCMD_DIR}/linux64/steam"
fi

mkdir --parents "${STEAMCMD_DIR}/linux32"
if [ ! -e "${STEAMCMD_DIR}/linux32/steamservice.so" ]; then
    ln --force --symbolic "${STEAMCMD_DIR}/linux32/steamclient.so" "${STEAMCMD_DIR}/linux32/steamservice.so"
fi
if [ ! -e "${STEAMCMD_DIR}/linux32/steam" ]; then
    ln --force --symbolic "${STEAMCMD_DIR}/linux32/steamcmd" "${STEAMCMD_DIR}/linux32/steam"
fi

