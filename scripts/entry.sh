#!/bin/sh
set -e

if [ -f ~/workspace/.config ]
  then
  else
    mkdir ~/workspace/.config
fi

if [ -f ~/workspace/.config/ssh ]
  then
    cp -R ~/workspace/.config/ssh /root/.ssh
    chmod 700 /root/.ssh
    chmod 644 /root/.ssh/id_rsa.pub
    chmod 600 /root/.ssh/id_rsa
  else
    echo "SSH config not found"
fi

exec "$@"
