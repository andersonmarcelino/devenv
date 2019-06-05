#!/bin/sh

echo 'configuring your envioriment'
rm ~/workspace/.config/gitconfig.local || true
echo 'your name: '
read username
echo 'your email:'
read useremail

echo "[user]
  name = $username
  email = $useremail" > ~/workspace/.config/gitconfig.local

echo "generating ssh"
cat /dev/zero | ssh-keygen -q -N "" > /dev/null
cp -R /root/.ssh  ~/workspace/.config/ssh
cat ~/workspace/.config/ssh/id_rsa.pub
