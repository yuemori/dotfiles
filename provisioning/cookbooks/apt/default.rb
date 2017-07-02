execute 'apt-get update' do
  user 'root'
end

%w[zip unzip tar curl wget sudo make git software-properties-common golang].each do |item|
  package item do
    user 'root'
  end
end

case node[:platform]
when 'ubuntu'
  execute 'wget https://github.com/motemen/ghq/releases/download/v0.7.4/ghq_linux_amd64.zip -O /tmp/ghq.zip' do
    not_if 'test $(which ghq)'
    user 'root'
  end

  execute 'unzip /tmp/ghq.zip -d /tmp/ghq && mv /tmp/ghq/ghq /usr/bin/ghq && chmod +x /usr/bin/ghq' do
    not_if 'test $(which ghq)'
    user 'root'
  end

  execute 'wget https://github.com/peco/peco/releases/download/v0.5.1/peco_linux_amd64.tar.gz -O /tmp/peco.tar.gz' do
    not_if 'test $(which peco)'
    user 'root'
  end

  execute 'tar -zxvf /tmp/peco.tar.gz -C /tmp && mv /tmp/peco_linux_amd64/peco /usr/bin/peco && chmod +x /usr/bin/peco' do
    not_if 'test $(which peco)'
    user 'root'
  end
end
