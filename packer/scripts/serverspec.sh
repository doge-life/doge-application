#!/bin/bash

function as_root() {
    if [[ $EUID != 0 ]]; then
        sudo -i "$@"
    else
        "$@"
    fi
}

source $HOME/.bash_profile
as_root gem install bundler --no-ri --no-rdoc
cd /tmp/tests
bundle install
bundle exec rake spec

