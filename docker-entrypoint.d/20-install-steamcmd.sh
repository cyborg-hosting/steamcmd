#!/bin/sh

set -o errexit

if [ -f "${STEAMCMD_DIR}" ]; then
    exit 1
fi

mkdir --parents "${STEAMCMD_DIR}"
chown "${PUID}:${PGID}" "${STEAMCMD_DIR}"
chmod "u+rwx" "${STEAMCMD_DIR}"
