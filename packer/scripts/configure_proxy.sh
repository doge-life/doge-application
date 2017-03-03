#!/bin/bash -e

function as_root() {
    if [[ $EUID != 0 ]]; then
        sudo -i "$@"
    else
        "$@"
    fi
}

if [[ ! -z $PROXY_HOST ]]; then
    export http_proxy="http://$PROXY_UNAME:$PROXY_PASSWORD@$PROXY_HOST:$PROXY_PORT"
    as_root echo "Acquire::http::Proxy \"http://$PROXY_UNAME:$PROXY_PASSWORD@$PROXY_HOST:$PROXY_PORT\";" \
        > /etc/apt/apt.conf.d/00AscenaProxy
else
    printf 'PROXY_HOST does not seem to have been set...\n'
    printf 'If a proxy is needed, please set these environment variables:\n'
    printf 'ASCENA_PROXY_HOST\n'
    printf 'ASCENA_PROXY_PORT\n'
    printf 'ASCENA_PROXY_UNAME\n'
    printf 'ASCENA_PROXY_PASSWORD\n'
    printf 'Continuing without proxy...\n'
fi
