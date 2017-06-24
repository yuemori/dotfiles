#!/bin/bash

if [ ! $(which mitamae) ];then
  wget https://github.com/itamae-kitchen/mitamae/releases/download/v1.4.5/mitamae-x86_64-darwin -O /usr/bin/mitamae
  chmod +x /usr/bin/itamae
fi

wget https://raw.githubusercontent.com/yuemori/dotfiles/master/provision.rb -O /tmp/provision.rb

mitamae local --log-level=debug /tmp/provision.rb
