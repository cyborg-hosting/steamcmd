#!/bin/sh

set -o errexit

if find "/docker-entrypoint.d/" -mindepth 1 -maxdepth 1 -type f -print -quit 2>/dev/null | read v; then
    find "/docker-entrypoint.d/" -follow -type f -print | sort -V | while read -r f; do
        case "$f" in
            *.env.sh)
                if [ -x "$f" ]; then
                    . "$f"
                fi
                ;;
            *.user.sh)
                if [ -x "$f" ]; then
                    gosu "${PUID}:${PGID}" "$f"
                fi
                ;;
            *.sh)
                if [ -x "$f" ]; then
                    "$f"
                fi
                ;;
        esac
    done
fi

exec gosu "${PUID}:${PGID}" "$@"
