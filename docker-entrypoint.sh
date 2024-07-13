#!/bin/sh

set -eu

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
                    sudo --set-home --preserve-env 'PATH=/usr/local/bin:/usr/bin:/bin' --user="#${PUID}" --group="#${PGID}" "$f"
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

exec sudo --set-home --preserve-env 'PATH=/usr/local/bin:/usr/bin:/bin' --user="user" "$@"
