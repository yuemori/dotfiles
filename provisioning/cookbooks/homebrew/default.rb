execute "ruby -e \"$(curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/master/install')\"" do
  not_if 'test $(which brew)'
end

execute "brew bundle --file=~/dotfiles/Brewfile" do
  not_if "brew bundle check --file=~/dotfiles/Brewfile"
end

directory "#{node[:home]}/Library/LaunchAgents"

link "#{node[:home]}/Library/LaunchAgents/localhost.homebrew-upgrade.plist" do
  to "#{node[:repo]}/confs/localhost.homebrew-upgrade.plist"
  force true
end
