#!/bin/bash

set -eux

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap Homebrew/bundle
sleep 5
brew update
brew bundle install --force

# files
ln -vnsf ${HOME}/dotfiles/.vimrc ~/.vimrc
ln -vnsf ${HOME}/dotfiles/.gvimrc ~/.gvimrc
ln -vnsf ${HOME}/dotfiles/.tmux.conf ~/.tmux.conf
ln -vnsf ${HOME}/dotfiles/.zshrc ~/.zshrc
ln -vnsf ${HOME}/dotfiles/.gitignore ~/.gitignore
ln -vnsf ${HOME}/dotfiles/.gitignore_global ~/.gitignore_global
ln -vnsf ${HOME}/dotfiles/.tigrc ~/.tigrc
ln -vnsf ${HOME}/dotfiles/dein.toml ~/.dein.toml
ln -vnsf ${HOME}/dotfiles/dein_lazy.toml ~/.dein_lazy.toml
mkdir -p ${HOME}/.config/nvim
ln -snfv ${HOME}/.vim ${HOME}/.config/nvim/
ln -snfv ${HOME}/.vimrc ${HOME}/.config/nvim/init.vim

# directories
ln -vnsf ~/dotfiles/.peco ~/
ln -vnsf ~/dotfiles/.git_tmp ~/
ln -vnsf ~/dotfiles/.vim ~/
ln -vnsf ~/dotfiles/.zsh ~/

cp ${HOME}/dotfiles/localhost.homebrew-upgrade.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/localhost.homebrew-upgrade.plist
