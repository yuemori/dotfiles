if [ ! $(which mitamae) ];then
  wget https://github.com/itamae-kitchen/mitamae/releases/download/v1.4.5/mitamae-x86_64-darwin -O /usr/bin/mitamae
  chmod +x /usr/bin/itamae
fi

if [ ! $(which git) ];then
  brew install git
fi

mkdir -p ~/ghq/github.com/yuemori
if [ -z "$(ls -A ~/ghq/github.com/yuemori)" ];then
  git clone https://github.com/yuemori/dotfiles.git ~/ghq/github.com/yuemori
fi

echo "Start Dry run..."
mitamae local --dry-run provision.rb

echo "Start provisioning..."
mitamae local provision.rb
