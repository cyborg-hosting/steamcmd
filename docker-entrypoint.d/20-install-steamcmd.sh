#!/bin/sh

set -eu

if [ -f "${STEAMCMD_DIR}" ]; then
	>&2 echo "\"${STEAMCMD_DIR}\" is not directory"
	exit 1
elif [ ! -d "${STEAMCMD_DIR}" ]; then
	mkdir --parents "${STEAMCMD_DIR}"
fi

chown "${PUID}:${PGID}" "${STEAMCMD_DIR}"
chmod "u+rwx" "${STEAMCMD_DIR}"

