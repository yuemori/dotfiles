case node[:platform]
when 'ubuntu'
  package 'vim'
  package 'software-properties-common'

  execute 'add-apt-repository ppa:neovim-ppa/stable -y && apt-get update -y' do
    not_if 'test $(which nvim)'
  end

  package 'neovim'
end

directory "#{node[:home]}/.config" do
  user node[:current_user]
end

link "#{node[:home]}/.config/nvim" do
  user node[:current_user]
  to "#{node[:repo]}/vim"
  force true
end

link "#{node[:home]}/.vim" do
  user node[:current_user]
  to "#{node[:repo]}/vim"
  force true
end

link "#{node[:home]}/.vimrc" do
  user node[:current_user]
  to "#{node[:repo]}/vim/vimrc"
  force true
end

directory "#{node[:home]}/.cache/dein"

execute "wget https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh -O /tmp/installer.sh" do
  not_if "test -e #{node[:home]}/.cache/dein/repos/github.com/Shougo/dein.vim"
  user node[:current_user]
end

execute "sh /tmp/installer.sh #{node[:home]}/.cache/dein" do
  not_if "test -e #{node[:home]}/.cache/dein/repos/github.com/Shougo/dein.vim"
  user node[:current_user]
end

include_recipe '../pyenv'

%w[2 3].each do |version|
  execute "#{node[:pyenv]} virtualenv python#{version} neovim#{version}" do
    not_if "#{node[:pyenv]} versions | grep neovim#{version}"
    user node[:current_user]
  end

  execute "#{node[:pyenv]} activate neovim#{version} && pip install neovim" do
    not_if "#{node[:pyenv]} activate neovim#{version} && pip list --format=columns | grep neovim"
    user node[:current_user]
  end
end

execute "#{node[:rbenv]} shell 2.4.1 && gem install neovim" do
  not_if "#{node[:rbenv]} shell 2.4.1 && gem search --installed neovim"
  user node[:current_user]
end
