#!/bin/sh

echo "generating ssh"
cat /dev/zero | ssh-keygen -q -N "" > /dev/null
cp -R /root/.ssh  ~/workspace/.config/ssh
cat ~/workspace/.config/ssh/id_rsa.pub
