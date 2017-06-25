case node[:platform]
when 'ubuntu'
  package 'vim'
  package 'software-properties-common'

  execute 'add-apt-repository ppa:neovim-ppa/stable -y && apt-get update -y' do
    not_if 'test $(which nvim)'
  end

  package 'neovim'
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
