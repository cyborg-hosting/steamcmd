#!/bin/sh

set -o errexit

HOME_DIR="/home/user"

if [ -f "${HOME_DIR}" ]; then
    exit 1
fi

mkdir --parents "${HOME_DIR}"
chown "${PUID}:${PGID}" "${HOME_DIR}"
chmod "u+rwx" "${HOME_DIR}"

if getent group "user" >/dev/null 2>&1; [ "$?" -ne "0" ]; then
    groupadd --non-unique --gid="${PGID}" "user"
fi


if getent passwd "user" >/dev/null 2>&1; [ "$?" -ne "0" ]; then
    useradd --non-unique --no-create-home --home-dir="${HOME_DIR}" --uid="${PUID}" --gid="${PGID}" "user"
fi

export LD_LIBRARY_PATH="${STEAMCMD_DIR}/linux64:${STEAMCMD_DIR}/linux32${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"

