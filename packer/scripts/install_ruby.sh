#!/bin/bash

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get install -y ruby
sudo rm -rf /var/lib/apt/lists/*

