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

echo -n "enable trezor-gpg? (Y/n)"
read trezor

if [[ $trezor == "Y" || $trezor == "y" ]]
then
  if host -t a host.docker.internal;
  then
    socat TCP4-LISTEN:21325,fork,reuseaddr TCP4:host.docker.internal:21325 &
  fi

  rm -rf ~/.gnupg/trezor/
  trezor-gpg init "$username <$useremail>" -v -t 0

  cat > ~/workspace/.config/trezorconfig << TREZORCONFIG
  export GNUPGHOME=~/.gnupg/trezor
TREZORCONFIG

  source ~/workspace/.config/trezorconfig

  signingkey=$(gpg --list-secret-keys --keyid-format LONG | grep sec | cut -d/ -f2 | cut -d' ' -f 1)

   cat >> ~/workspace/.config/gitconfig.local << GITGPG
  signingkey = $signingkey
[commit]
  gpgsign = true
GITGPG

  cp -R /root/.gnupg  ~/workspace/.config/gnupg

  echo "Your key \n"
  gpg --armor --export $signingkey
else
  echo "generating ssh"
  cat /dev/zero | ssh-keygen -q -N "" > /dev/null
  cp -R /root/.ssh  ~/workspace/.config/ssh
  cat ~/workspace/.config/ssh/id_rsa.pub
fi

