case node[:platform]
when 'ubuntu'
  %w[
    autoconf bison build-essential libssl-dev libyaml-dev
    libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
  ].each do |p|
    package p
  end

  git "#{node[:home]}/.rbenv" do
    repository 'https://github.com/rbenv/rbenv.git' 
  end

  git "#{node[:home]}/.rbenv/plugins/ruby-build" do
    repository 'https://github.com/rbenv/ruby-build.git'
  end

  node[:rbenv] = "#{node[:home]}/.rbenv/bin/rbenv"
when 'darwin'
  node[:rbenv] = "/usr/local/bin/rbenv"
end

%w[2.4.1].each do |version|
  execute "rbenv install #{version}" do
    not_if "#{node[:rbenv]} versions | grep -e #{version}"
  end
end