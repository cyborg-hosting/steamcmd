#!/bin/sh

if [ ! -r "${HOME}" ] || [ ! -w "${HOME}" ] || [ ! -x "${HOME}" ]; then
    exit 1
fi
