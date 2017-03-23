#!/bin/bash

sudo gem install bundler --no-ri --no-rdoc
cd /tmp/tests
bundle install
sudo bundle exec rake spec
