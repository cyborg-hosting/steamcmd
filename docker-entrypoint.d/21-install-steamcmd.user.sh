#!/bin/sh

set -o errexit

if [ ! -f "${STEAMCMD_DIR}/steamcmd.sh" ]; then
    curl --fail --silent --show-error --location "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar --extract --gzip --file=- --directory="${STEAMCMD_DIR}"
fi

if [ ! -L "${HOME}/.steam/sdk32/steamclient.so" ]; then
    mkdir -p "${HOME}/.steam/sdk32" || true
    ln -s "${STEAMCMD_DIR}/linux32/steamclient.so" "${HOME}/.steam/sdk32/steamclient.so"
fi
if [ ! -L "${HOME}/.steam/sdk64/steamclient.so" ]; then
    mkdir -p "${HOME}/.steam/sdk64" || true
    ln -s "${STEAMCMD_DIR}/linux64/steamclient.so" "${HOME}/.steam/sdk64/steamclient.so"
fi
if [ ! -L "${STEAMCMD_DIR}/steamservice.so" ]; then
    ln -s "${STEAMCMD_DIR}/linux32/steamclient.so" "${STEAMCMD_DIR}/steamservice.so"
fi
