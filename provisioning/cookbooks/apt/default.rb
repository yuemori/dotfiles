execute 'apt-get update'

%w[curl wget sudo make git software-properties-common].each do |item|
  package item
end
