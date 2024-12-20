case node[:platform]
when 'ubuntu'
  %w[
    make build-essential libssl-dev zlib1g-dev libbz2-dev
    libreadline-dev libsqlite3-dev wget curl llvm 
    libncurses5-dev libncursesw5-dev xz-utils tk-dev
  ].each do |p|
    package p do
      user 'root'
    end
  end

  git "#{node[:home]}/.pyenv" do
    repository 'https://github.com/yyuu/pyenv.git' 
  end

  git "#{node[:home]}/.pyenv/plugins/pyenv-virtualenv" do
    repository 'https://github.com/yyuu/pyenv-virtualenv.git'
  end
end

