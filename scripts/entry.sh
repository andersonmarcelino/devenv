#!/bin/sh
set -e

if [ ! -d ~/workspace/.config ]
  then
    mkdir ~/workspace/.config
fi

if [ -d ~/workspace/.config/ssh ]
  then
    cp -R ~/workspace/.config/ssh /root/.ssh
    chmod 700 /root/.ssh
    chmod 644 /root/.ssh/id_rsa.pub
    chmod 600 /root/.ssh/id_rsa
fi

exec "$@"
