%w[apt-transport-https ca-certificates curl software-properties-common lsb_release].each do |item|
  package item do
    user 'root'
  end
end

command 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -' do
	user 'root'
  not_if 'test $(which docker)'
end

command 'apt-key fingerprint 0EBFCD88' do
	user 'root'
  not_if 'test $(which docker)'
end

command 'add-apt-repository \ "deb [arch=amd64] https://download.docker.com/linux/ubuntu \ $(lsb_release -cs) \ stable"' do
  user 'root'
  not_if 'test $(which docker)'
end

command 'apt-get update -y' do
	user 'root'
  not_if 'test $(which docker)'
end

package 'docker-ce' do
  user 'root'
end

service 'docker' do
  action :start

  # see: http://tuhrig.de/how-to-know-you-are-inside-a-docker-container/
  not_if 'cat awk -F/ '$2 == "docker"' /proc/self/cgroup | read'
end
