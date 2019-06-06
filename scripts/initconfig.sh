#!/bin/sh

currentname=$(git config -l | grep user.name | cut -d "=" -f 2-2)
currentemail=$(git config -l | grep user.email | cut -d "=" -f 2-2)

echo 'configuring your envioriment'

if [ -f ~/workspace/.config/gitconfig.local ]
  then
    rm ~/workspace/.config/gitconfig.local
fi

echo -n "your name ($currentname):"
read username
echo -n "your email ($currentemail):"
read useremail

if [ -z "$username" ]
  then
    username=$currentname
fi

if [ -z "$useremail" ]
  then
    useremail=$currentemail
fi

echo "[user]
  name = $username
  email = $useremail" > ~/workspace/.config/gitconfig.local

echo "generating ssh"
cat /dev/zero | ssh-keygen -q -N "" > /dev/null
cp -R /root/.ssh  ~/workspace/.config/ssh
cat ~/workspace/.config/ssh/id_rsa.pub
