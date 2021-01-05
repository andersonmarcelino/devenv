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

if [ -d ~/workspace/.config/gnupg ]
  then
    cp -R ~/workspace/.config/gnupg /root/.gnupg
    chmod 700 /root/.gnupg/trezor
    chmod 644 /root/.gnupg/trezor/*
    chmod 700 /root/.gnupg/trezor/env
    chmod 700 /root/.gnupg/trezor/run-agent.sh
    chmod 600 /root/.gnupg/trezor/pubring.kbx~
    chmod 600 /root/.gnupg/trezor/trustdb.gpg
fi

OPTIND=1

while getopts "s" opt; do
    case "$opt" in
    s)  echo -n "set a new root password:"
        stty -echo
        read password
        stty echo
        echo
        echo "root:$password" | chpasswd
        /usr/sbin/sshd
        ;;
    esac
done

shift $((OPTIND-1))

exec "$@"
