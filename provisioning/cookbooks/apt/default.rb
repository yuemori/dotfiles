execute 'apt-get update' do
  user 'root'
end

%w[zip unzip tar curl wget sudo make git software-properties-common golang].each do |item|
  package item do
    user 'root'
  end
end
