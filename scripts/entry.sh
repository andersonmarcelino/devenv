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

if [ ! -d ~/workspace/.config/github-copilot ]
  then
    mkdir -p ~/workspace/.config/github-copilot
fi

ln -s ~/workspace/.config/github-copilot ~/.config/github-copilot

if [ -d ~/workspace/.config/gnupg ]
  then
    cp -R ~/workspace/.config/gnupg ~/.gnupg
    chmod 700 ~/.gnupg/trezor
    chmod 644 ~/.gnupg/trezor/*
    chmod 700 ~/.gnupg/trezor/env
    chmod 700 ~/.gnupg/trezor/run-agent.sh
    chmod 600 ~/.gnupg/trezor/pubring.kbx~
    chmod 600 ~/.gnupg/trezor/trustdb.gpg
fi

if [[ -f ~/workspace/.config/trezorconfig ]]
  then
    if host -t a host.docker.internal;
    then
      socat TCP4-LISTEN:21325,fork,reuseaddr TCP4:host.docker.internal:21325 &
    fi
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
