#!/bin/bash

source $HOME/.bash_profile
sudo gem install bundler --no-ri --no-rdoc
cd /tmp/tests
bundle install
bundle exec rake spec

