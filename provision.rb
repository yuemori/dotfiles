HOME = "/Users/#{`whoami`.strip}".freeze
REPO = "#{HOME}/ghq/github.com/yuemori/dotfiles"

link "#{HOME}/dotfiles" do
  to REPO
  force true
end

# brew
execute 'Install brew' do
  command "ruby -e \"$(curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/master/install')\""
  not_if 'test $(which brew)'
end

execute 'Run brew bundle' do
  command "brew bundle --file=#{REPO}/Brewfile"
  not_if "brew bundle check --file=#{REPO}/Brewfile"
end

execute 'Creates LaunchAgents' do
  command "mkdir -p #{HOME}/Library/LaunchAgents"
  not_if "test -e ~/Library/LaunchAgents"
end

link "#{HOME}/Library/LaunchAgents/localhost.homebrew-upgrade.plist" do
  to "#{REPO}/confs/localhost.homebrew-upgrade.plist"
  force true
end

# create symlinks
%w(.agignore .bash_profile .bashrc .jshintrc .tmux.conf .zshrc .gitconfig .gitignore_global .tigrc).each do |item|
  link "#{HOME}/#{item}" do
    to "#{REPO}/#{item}"
    force true
  end
end

execute 'Creates ~/.config' do
  command "mkdir -p #{HOME}/.config"
  not_if "test -e #{HOME}/.config/"
end

link "#{HOME}/.config/nvim" do
  to "#{REPO}/vim"
  force true
end

link "#{HOME}/.vim" do
  to "#{REPO}/vim"
  force true
end

link "#{HOME}/.vimrc" do
  to "#{REPO}/vim/vimrc"
  force true
end

execute 'Creates shell cache' do
  command "mkdir -p #{HOME}/.cache/shell"
  not_if "test -e #{HOME}/.cache/shell"
end

execute 'Installs cool-peco' do
  command 'ghq get ryoppy/cool-peco'
  not_if 'test $(ghq list cool-peco)'
end

%w(.peco .git_tmp .zsh).each do |item|
  link "#{HOME}/#{item}" do
    to "#{REPO}/#{item}"
    force true
  end
end

# neovim
execute "Create dein directory" do
  command "mkdir -p #{HOME}/.cache/dein"
  not_if "test -e ~/.cache/dein/repos/github.com/Shougo/dein.vim"
end

execute "Downloads installer.sh" do
  command "wget https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh -O /tmp/installer.sh"
  not_if "test -e ~/.cache/dein/repos/github.com/Shougo/dein.vim"
end

execute "Execute installer.sh" do
  command "sh /tmp/installer.sh #{HOME}/.cache/dein"
  not_if "test -e ~/.cache/dein/repos/github.com/Shougo/dein.vim"
end

# pyenv
TARGET_PYTHON_VERSIONS = { 2 => "2.7.13", 3 => "3.6.1" }.freeze

TARGET_PYTHON_VERSIONS.each do |version, full_version|
  execute "Installs python #{full_version}" do
    command "pyenv install #{full_version}"
    not_if "export PYENV_ROOT=$HOME/.pyenv && eval \"$(pyenv init - )\" && eval \"$(pyenv virtualenv-init - )\" && pyenv versions | grep #{full_version} --silent"
  end

  execute "Creates virtualenv neovim-#{version}" do
    command "pyenv virtualenv #{full_version} neovim#{version}"
    not_if "export PYENV_ROOT=$HOME/.pyenv && eval \"$(pyenv init - )\" && eval \"$(pyenv virtualenv-init - )\" && pyenv versions | grep neovim#{version}"
  end

  execute "Installs neovim plugin" do
    command "export PYENV_ROOT=$HOME/.pyenv && eval \"$(pyenv init - )\" && eval \"$(pyenv virtualenv-init - )\" && pyenv activate neovim#{version} && pip install --upgrade pip neovim"
    not_if "export PYENV_ROOT=$HOME/.pyenv && eval \"$(pyenv init - )\" && eval \"$(pyenv virtualenv-init - )\" && pyenv activate neovim#{version} && pip list --format=columns | grep neovim --silent"
  end
end

# rbenv
TARGET_RUBY_VERSION = '2.4.1'.freeze

execute "Installs ruby #{TARGET_RUBY_VERSION}" do
  command "rbenv install #{TARGET_RUBY_VERSION} && rbenv global #{TARGET_RUBY_VERSION}"
  not_if "rbenv versions | grep #{TARGET_RUBY_VERSION} --silent"
end

execute "Installs neovim plugin" do
  command "gem install neovim"
  not_if "gem search --installed neovim"
end
