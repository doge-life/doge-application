#!/bin/bash -e

sudo mv ~/doge-webapp.jar /var/doge-webapp/doge-webapp.jar
sudo chmod 755 /var/doge-webapp/doge-webapp.jar
sudo ln -s /var/doge-webapp/doge-webapp.jar /etc/init.d/doge-webapp
sudo update-rc.d doge-webapp defaults
