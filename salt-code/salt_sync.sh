#!/bin/bash

sudo mkdir -p /srv

sudo rm -rf /srv/*

sudo cp -R salt /srv

sudo cp master /etc/salt

sudo systemctl restart salt-master
sudo systemctl status salt-master
