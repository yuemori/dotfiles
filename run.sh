#!/bin/bash

set -ex

case ${OSTYPE} in
  darwin*)
    if [ ! $(which mitamae) ];then
      wget https://github.com/itamae-kitchen/mitamae/releases/download/v1.4.5/mitamae-x86_64-darwin -O /usr/bin/mitamae
      chmod +x /usr/bin/itamae
    fi

    echo "{ \"home\":\"/Users/$USER\",\"current_user\":\"$USER\" }" > /tmp/node.json
  ;;

  linux*)
    if [ -z "$(which mitamae)" ];then
      sudo wget https://github.com/itamae-kitchen/mitamae/releases/download/v1.4.5/mitamae-x86_64-linux -O /usr/local/bin/mitamae
      sudo chmod +x /usr/local/bin/itamae
    fi

    if [ -z "$(which svn)" ];then
      sudo apt-get update -y
      sudo apt-get install subversion
    fi

    echo "{ \"home\":\"/home/$USER\",\"current_user\":\"$USER\" }" > /tmp/node.json
  ;;
esac


svn export --force https://github.com/yuemori/dotfiles.git/trunk/provisioning /tmp/provisioning
mitamae local --log-level=debug /tmp/provisioning/roles/dotfile.rb
