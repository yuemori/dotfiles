execute 'apt-get update'

%w[curl wget sudo make git].each do |item|
  package item
end
