require 'spec_helper'

%w[
  gitconfig gitignore_global git_tmp
  agignore bash_profile bashrc tmux.conf zshrc tigrc
].each do |item|
  link = file("#{ENV['HOME']}/.#{item}")

  describe link do
    it { should be_symlink }
  end

  describe file(link.link_target) do
    it { should exist }
  end
end
