node[:home] ||= `echo $HOME`.strip
node[:repo] ||= "#{node[:home]}/dotfiles"

git "#{node[:home]}/dotfiles" do
  repository 'https://github.com/yuemori/dotfiles'
end

case node[:platform]
when 'ubuntu'
  include_recipe '../cookbooks/apt'
when 'darwin'
  include_recipe '../cookbooks/homebrew'
end

include_recipe '../cookbooks/pyenv'
include_recipe '../cookbooks/rbenv'
include_recipe '../cookbooks/symlinks'
include_recipe '../cookbooks/vim'