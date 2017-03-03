#!/bin/bash

function as_root() {
    if [[ $EUID != 0 ]]; then
        sudo -i "$@"
    else
        "$@"
    fi
}

as_root apt-get update
as_root apt-get upgrade -y
as_root apt-get dist-upgrade -y
as_root apt-get install -y ruby
