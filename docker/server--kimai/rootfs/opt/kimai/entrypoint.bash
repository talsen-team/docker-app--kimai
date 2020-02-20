#!/bin/bash

set -euo pipefail

KIMAI_VAR_DIR="/opt/kimai/var"

function import_defaults() {
    local \
    DEFAULT_DIR="/default"

    if [ -z "$( ls ${KIMAI_VAR_DIR} )" ];
    then
        sudo \
        rsync \
        --archive \
        "${DEFAULT_DIR}/${KIMAI_VAR_DIR}/" \
        "${KIMAI_VAR_DIR}"
    fi
}

function clear_kimai_cache() {
    local \
    KIMAI_CACHE_DIR="${KIMAI_VAR_DIR}/cache"

    sudo \
    rm \
    -fr \
    "${KIMAI_CACHE_DIR}"
}

function fix_permissions() {
    sudo \
    chown \
    --recursive \
    www-data:www-data \
    "${KIMAI_VAR_DIR}"
}

function run_entrypoint() {
    import_defaults
    clear_kimai_cache
    fix_permissions

    /bin/bash \
    /startup.sh
}

run_entrypoint
