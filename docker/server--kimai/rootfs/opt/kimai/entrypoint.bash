#!/bin/bash

set -euo pipefail

function run_entrypoint() {
    local \
    DEFAULT_DIR="/default"

    local \
    KIMAI_VAR_DIR="/opt/kimai/var"

    local \
    KIMAI_CACHE_DIR="${KIMAI_VAR_DIR}/cache"

    if [ -z "$( ls ${KIMAI_VAR_DIR} )" ];
    then
        sudo \
        rsync \
        --archive \
        "${DEFAULT_DIR}/${KIMAI_VAR_DIR}/" \
        "${KIMAI_VAR_DIR}"
    fi

    sudo \
    rm \
    -fr \
    "${KIMAI_CACHE_DIR}"

    sudo \
    chown \
    --recursive \
    www-data:www-data \
    "${KIMAI_VAR_DIR}"

    /bin/bash \
    /startup.sh
}

run_entrypoint
