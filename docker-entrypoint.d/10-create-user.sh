#!/bin/sh

set -eu

export HOME_DIR="/home/user"

if ! getent group "user" >/dev/null; then
	groupadd --non-unique --gid="${PGID}" "user"
fi
if ! getent passwd "user" >/dev/null; then
	useradd --non-unique --no-create-home --home-dir="${HOME_DIR}" --uid="${PUID}" --gid="${PGID}" "user"
fi

if [ -f "${HOME_DIR}" ]; then
	>&2 echo "\"${HOME_DIR}\" is not directory"
	exit 1
elif [ ! -d "${HOME_DIR}" ]; then
	mkdir --parents "${HOME_DIR}"
fi

chown "${PUID}:${PGID}" "${HOME_DIR}"
chmod "u+rwx" "${HOME_DIR}"
