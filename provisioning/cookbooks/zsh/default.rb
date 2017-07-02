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
  remote_file '/tmp/ghq.zip' do
    source 'https://github.com/motemen/ghq/releases/download/v0.7.4/ghq_linux_amd64.zip'
    not_if 'test $(which ghq)'
  end

  execute 'unzip /tmp/ghq.zip -d /tmp/ghq && mv /tmp/ghq/ghq /usr/bin/ghq && chmod +x /usr/bin/ghq' do
    not_if 'test $(which ghq)'
  end

  remote_file '/tmp/peco.tar.gz' do
    source 'https://github.com/peco/peco/releases/download/v0.5.1/peco_linux_amd64.tar.gz'
    not_if 'test $(which peco)'
  end

  execute 'tar -zxvf /tmp/peco.tar.gz -C /tmp && mv /tmp/peco_linux_amd64/peco /usr/bin/peco && chmod +x /usr/bin/peco' do
    not_if 'test $(which peco)'
  end

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
