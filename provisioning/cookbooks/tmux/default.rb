%w[automake libevent-dev libncurses5-dev pkg-config autoconf m4 libtool perl].each do |item|
  package item do
    user 'root'
  end
end

git '/tmp/tmux' do
  repository 'https://github.com/tmux/tmux.git'
  revision '2.5'

  not_if 'test $(which tmux)'
end

execute 'sh autogen.sh && ./configure && make -j4 && make install' do
  cwd '/tmp/tmux'
  user 'root'

  not_if 'test $(which tmux)'
end
