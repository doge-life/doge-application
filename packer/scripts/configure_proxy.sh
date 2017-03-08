#!/bin/bash -ex

# This script is meant to be used with docker and is always run as root.

if [[ ! -z $PROXY_HOST ]]; then
    echo "Proxy found...adding to environment and apt config"
    export http_proxy="http://$PROXY_UNAME:$PROXY_PASSWORD@$PROXY_HOST:$PROXY_PORT"
    echo "Acquire::http::Proxy \"http://$PROXY_UNAME:$PROXY_PASSWORD@$PROXY_HOST:$PROXY_PORT\";" \
        > /etc/apt/apt.conf.d/00DogeProxy
else
    printf 'PROXY_HOST does not seem to have been set...\n'
    printf 'If a proxy is needed, please set these environment variables:\n'
    printf 'DOGE_PROXY_HOST\n'
    printf 'DOGE_PROXY_PORT\n'
    printf 'DOGE_PROXY_UNAME\n'
    printf 'DOGE_PROXY_PASSWORD\n'
    printf 'Continuing without proxy...\n'
fi
