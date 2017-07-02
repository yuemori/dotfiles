#!/bin/bash

set -exu

case ${OSTYPE} in
  darwin*)
    if [ ! $(which mitamae) ];then
      wget https://github.com/itamae-kitchen/mitamae/releases/download/v1.4.5/mitamae-x86_64-darwin -O /usr/bin/mitamae
      chmod +x /usr/bin/mitamae
    fi

    echo "{ \"home\":\"/Users/$USER\",\"current_user\":\"$USER\" }" > $HOME/node.json

    svn export --force https://github.com/yuemori/dotfiles.git/trunk/provisioning /tmp/provisioning
    mitamae local --log-level=debug /tmp/provisioning/roles/dotfile.rb -j $HOME/node.json
  ;;

  linux*)
    if [ -z "$(which mitamae)" ];then
      sudo wget https://github.com/itamae-kitchen/mitamae/releases/download/v1.4.5/mitamae-x86_64-linux -O /usr/local/bin/mitamae
      sudo chmod +x /usr/local/bin/mitamae
    fi

    if [ -z "$(which svn)" ];then
      sudo apt-get update -y
      sudo apt-get install -y subversion
    fi

    echo "{ \"home\":\"/home/$USER\",\"current_user\":\"$USER\" }" > $HOME/node.json

    sudo rm -rf /tmp/provisioning
    sudo svn export --force https://github.com/yuemori/dotfiles.git/trunk/provisioning /tmp/provisioning
    sudo chown -R $USER:$USER /tmp/provisioning
    mitamae local --log-level=debug /tmp/provisioning/roles/dotfile.rb -j $HOME/node.json
  ;;
esac
