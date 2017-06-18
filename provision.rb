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

link "#{HOME}/Library/LaunchAgents/localhost.homebrew-upgrade.plist" do
  to "#{REPO}/localhost.homebrew-upgrade.plist"
  force true
end

# create symlinks
%w(.agignore .bash_profile .bashrc .jshintrc .vimrc .tmux.conf .zshrc .gitignore_global .tigrc dein.toml dein_lazy.toml).each do |item|
  link "#{HOME}/#{item}" do
    to "#{REPO}/#{item}"
    force true
  end
end

execute 'Creates nvim' do
  command "mkdir -p #{HOME}/.config/nvim"
  not_if "test -e ~/.config/nvim"
end

%w(.peco .git_tmp .vim .zsh).each do |item|
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
TARGET_PYTHON_VERSIONS = %w(2.7.13 3.6.1).freeze

TARGET_PYTHON_VERSIONS.each do |version|
  execute "Installs python #{version}" do
    command "pyenv install #{version}"
    not_if "export PYENV_ROOT=$HOME/.pyenv && eval \"$(pyenv init - )\" && eval \"$(pyenv virtualenv-init - )\" && pyenv versions | grep #{version} --silent"
  end

  execute "Creates virtualenv neovim-#{version}" do
    command "pyenv virtualenv #{version} neovim-#{version}"
    not_if "export PYENV_ROOT=$HOME/.pyenv && eval \"$(pyenv init - )\" && eval \"$(pyenv virtualenv-init - )\" && pyenv versions | grep neovim-#{version}"
  end

  execute "Installs neovim plugin" do
    command "export PYENV_ROOT=$HOME/.pyenv && eval \"$(pyenv init - )\" && eval \"$(pyenv virtualenv-init - )\" && pyenv activate neovim-#{version} && pip install --upgrade pip neovim"
    not_if "export PYENV_ROOT=$HOME/.pyenv && eval \"$(pyenv init - )\" && eval \"$(pyenv virtualenv-init - )\" && pyenv activate neovim-#{version} && pip list --format=columns | grep neovim --silent"
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
