directory "#{node[:home]}/.cache/shell"
link "#{node[:home]}/.zshrc" do
  to "#{node[:repo]}/.zshrc"
end

link "#{node[:home]}/.zsh" do
  to "#{node[:repo]}/.zsh"
end

execute 'ghq get ryoppy/cool-peco' do
  not_if 'test $(ghq list cool-peco)'
end

link "#{node[:home]}/.peco" do
  to "#{node[:repo]}/.peco"
end

case node[:platform]
when 'ubuntu'
  execute 'echo "/usr/local/bin/zsh" >> /etc/shells' do
    not_if 'test $(grep -E /usr/bin/zsh /etc/shells)'
  end

  execute "chsh -s /usr/bin/zsh #{node[:current_user]}" do
    not_if "test $(echo $SHELL | grep -E '\/usr\/bin\/zsh')"
  end
when 'darwin'
  execute 'sudo bash -lc \'echo "/usr/local/bin/zsh" >> /etc/shells\'' do
    not_if 'test $(grep /usr/local/bin/zsh /etc/shells)'
  end

  execute 'sudo chsh -s /usr/local/bin/zsh' do
    not_if 'test $(echo $SHELL | grep zsh)'
  end
end
