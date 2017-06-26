%w(gitconfig gitignore_global git_tmp).each do |item|
  link "#{node[:home]}/.#{item}" do
    to "#{node[:repo]}/git/#{item}"
    user node[:current_user]
    force true
  end
end

%w(.agignore .bash_profile .bashrc .tmux.conf .zshrc .tigrc).each do |item|
  link "#{node[:home]}/#{item}" do
    to "#{node[:repo]}/#{item}"
    user node[:current_user]
    force true
  end
end
