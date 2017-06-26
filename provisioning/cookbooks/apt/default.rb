execute 'apt-get update'

%w[zip unzip tar curl wget sudo make git software-properties-common golang].each do |item|
  package item
end
