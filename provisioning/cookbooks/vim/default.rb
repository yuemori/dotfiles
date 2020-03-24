case node[:platform]
when 'ubuntu'
  package 'vim' do
    user 'root'
  end

  package 'software-properties-common' do
    user 'root'
  end

  execute 'add-apt-repository ppa:neovim-ppa/stable -y && apt-get update -y' do
    not_if 'test $(which nvim)'
    user 'root'
  end

  package 'neovim' do
    user 'root'
  end
end

directory "#{node[:home]}/.config"

link "#{node[:home]}/.config/nvim" do
  to "#{node[:repo]}/vim"
  force true
end

link "#{node[:home]}/.vim" do
  to "#{node[:repo]}/vim"
  force true
end

link "#{node[:home]}/.vimrc" do
  to "#{node[:repo]}/vim/vimrc"
  force true
end

directory "#{node[:home]}/.cache/dein"

execute "wget https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh -O /tmp/installer.sh" do
  not_if "test -e #{node[:home]}/.cache/dein/repos/github.com/Shougo/dein.vim"
end

execute "sh /tmp/installer.sh #{node[:home]}/.cache/dein" do
  not_if "test -e #{node[:home]}/.cache/dein/repos/github.com/Shougo/dein.vim"
end

include_recipe '../pyenv'

%w[2 3].each do |version|
  execute "bash -lc \"pyenv virtualenv python#{version} neovim#{version}\"" do
    not_if "bash -lc \"pyenv versions | grep neovim#{version}\""
  end

  execute "bash -lc \"pyenv activate neovim#{version} && pip install neovim\"" do
    not_if "bash -lc \"pyenv activate neovim#{version} && pip list --format=columns | grep neovim\""
  end
end

execute "bash -lc \"rbenv shell 2.6.3 && gem install neovim\"" do
  not_if "bash -lc \"rbenv shell 2.6.3 && gem search --installed neovim\""
end
