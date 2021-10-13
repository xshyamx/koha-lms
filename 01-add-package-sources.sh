#!/bin/sh

apt-get update
apt-get -y install sudo wget gnupg
wget -q -O- https://debian.koha-community.org/koha/gpg.asc | sudo apt-key add -
sudo apt-get update
