require 'spec_helper'

describe command('which nvim') do
  its(:exit_status) { should eq 0 }
end

describe file("#{ENV['HOME']}/.config") do
  it { should exist }
end

%w[.config/nvim .vim .vimrc].each do |item|
  link = file("#{ENV['HOME']}/#{item}")

  describe link do
    it { should be_symlink }
  end

  describe file(link.link_target) do
    it { should exist }
  end
end

describe file("#{ENV['HOME']}/.cache/dein") do
  it { should exist }
end

describe file("#{ENV['HOME']}/.cache/dein/repos/github.com/Shougo/dein.vim") do
  it { should exist }
end

describe command('bash -lc "pyenv versions"') do
  its(:stdout) { should match /neovim2/ }
end

describe command('bash -lc "pyenv versions"') do
  its(:stdout) { should match /neovim3/ }
end

describe command('bash -lc "rbenv shell 2.4.1 && gem search --installed neovim"') do
  its(:exit_status) { should eq 0 }
end
