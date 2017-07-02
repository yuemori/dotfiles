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

{ 2 => "2.7.13", 3 => "3.6.1" }.each do |version, full_version|
  execute "bash -lc \"pyenv install #{full_version}\"" do
    not_if "bash -lc \"pyenv versions | grep #{full_version}\""
  end

  execute "bash -lc \"pyenv virtualenv #{full_version} python#{version}\"" do
    not_if "bash -lc \"pyenv versions | grep -e ^\\\s*python#{version}$\""
  end
end
