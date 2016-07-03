#! /bin/bash
# files
ln -vnsf ~/dotfiles/.vimrc ~/.vimrc
ln -vnsf ~/dotfiles/.gvimrc ~/.gvimrc
ln -vnsf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -vnsf ~/dotfiles/.zshrc ~/.zshrc
ln -vnsf ~/dotfiles/.gitignore ~/.gitignore
ln -vnsf ~/dotfiles/.gitignore_global ~/.gitignore_global
ln -vnsf ~/dotfiles/.tigrc ~/.tigrc
ln -vnsf ~/dotfiles/dein.toml ~/.dein.toml
ln -vnsf ~/dotfiles/dein_lazy.toml ~/.dein_lazy.toml
mkdir -p ${HOME}/.config/nvim
ln -snfv ${HOME}/.vim ${HOME}/.config/nvim/
ln -snfv ${HOME}/.vimrc ${HOME}/.config/nvim/init.vim

# directories
ln -vnsf ~/dotfiles/.peco ~/
ln -vnsf ~/dotfiles/.git_tmp ~/
ln -vnsf ~/dotfiles/.vim ~/
ln -vnsf ~/dotfiles/.zsh ~/
