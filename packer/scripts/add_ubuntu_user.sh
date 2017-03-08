#!/bin/bash

echo "Installing sudo"
apt-get update
apt-get install sudo
rm -rf /var/lib/apt/lists/*

echo "Adding ubuntu user"
echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/ubuntu

adduser --disabled-password --gecos '' ubuntu

