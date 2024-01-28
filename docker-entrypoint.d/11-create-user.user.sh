#!/bin/sh

if [ ! -r "${HOME_DIR}" ] || [ ! -w "${HOME_DIR}" ] || [ ! -x "${HOME_DIR}" ]; then
    exit 1
fi
