#!/bin/sh
set -e

if [ ! -d ~/workspace/.config ]
  then
    mkdir ~/workspace/.config
fi

if [ ! -f ~/workspace/.config/zsh_history ]
  then
    touch ~/workspace/.config/zsh_history
fi

ln -s ~/workspace/.config/zsh_history ~/.zsh_history

if [ -d ~/workspace/.config/ssh ]
  then
    cp -R ~/workspace/.config/ssh /root/.ssh
    chmod 700 /root/.ssh
    chmod 644 /root/.ssh/id_rsa.pub
    chmod 600 /root/.ssh/id_rsa
fi

exec "$@"
