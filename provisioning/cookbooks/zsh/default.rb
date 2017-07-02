directory "#{node[:home]}/.cache/shell"
link "#{node[:home]}/.zshrc" do
  to "#{node[:repo]}/.zshrc"
end

link "#{node[:home]}/.zsh" do
  to "#{node[:repo]}/.zsh"
end

git "#{node[:home]}/ghq/github.com/ryoppy/cool-peco" do
  repository 'https://github.com/ryoppy/cool-peco'
  not_if 'test $(ghq list cool-peco)'
end

link "#{node[:home]}/.peco" do
  to "#{node[:repo]}/.peco"
end

case node[:platform]
when 'ubuntu'
  execute 'echo "/usr/local/bin/zsh" >> /etc/shells' do
    not_if 'test $(grep -E /usr/bin/zsh /etc/shells)'
    user 'root'
  end

  execute "chsh -s /usr/bin/zsh #{node[:current_user]}" do
    not_if "test $(echo $SHELL | grep -E '\/usr\/bin\/zsh')"
    user 'root'
  end
when 'darwin'
  execute 'echo "/usr/local/bin/zsh" >> /etc/shells' do
    not_if 'test $(grep /usr/local/bin/zsh /etc/shells)'
    user 'root'
  end

  execute 'chsh -s /usr/local/bin/zsh' do
    not_if 'test $(echo $SHELL | grep zsh)'
    user 'root'
  end
end
