case node[:platform]
when 'ubuntu'
  %w[
    autoconf bison build-essential libssl-dev libyaml-dev
    libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
  ].each do |p|
    package p do
      user 'root'
    end
  end

  git "#{node[:home]}/.rbenv" do
    repository 'https://github.com/rbenv/rbenv.git' 
  end

  git "#{node[:home]}/.rbenv/plugins/ruby-build" do
    repository 'https://github.com/rbenv/ruby-build.git'
  end
end

%w[2.4.1].each do |version|
  execute "bash -lc \"rbenv install #{version}\"" do
    not_if "bash -lc \"rbenv versions | grep -e #{version}\""
  end
end

execute "bash -lc \"rbenv global 2.4.1\"" do
  not_if "bash -lc \"rbenv version | grep 2.4.1\""
end
