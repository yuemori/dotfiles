node[:current_user] ||= `whoami`.strip
node[:home] ||= `echo $HOME`.strip
node[:repo] ||= "#{node[:home]}/dotfiles"

case node[:platform]
when 'ubuntu'
  include_recipe '../cookbooks/apt'
when 'darwin'
  include_recipe '../cookbooks/homebrew'
end

git "#{node[:home]}/dotfiles" do
  repository 'https://github.com/yuemori/dotfiles'
end

include_recipe '../cookbooks/symlinks'
include_recipe '../cookbooks/zsh'
include_recipe '../cookbooks/tmux' if node[:platform] == 'ubuntu'
include_recipe '../cookbooks/pyenv'
include_recipe '../cookbooks/rbenv'
include_recipe '../cookbooks/vim'
