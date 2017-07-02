require 'spec_helper'

describe file("#{ENV['HOME']}/.cache/shell") do
  it { should exist }
end

%w[.zshrc .zsh .peco].each do |item|
  link = file("#{ENV['HOME']}/#{item}")

  describe link do
    it { should be_symlink }
  end

  describe file(link.link_target) do
    it { should exist }
  end
end

describe command("zsh -lc 'source ~/.zshrc && which cool-peco'") do
  its(:exit_status) { should eq 0 }
end

describe package('zsh') do
  it { should be_installed }
end

describe file('/etc/shells') do
  its(:content) { should match /zsh/ }
end

describe command("cat /etc/passwd | grep #{ENV['USER']}"), if: os[:family] == 'ubuntu' do
  its(:stdout) { should match /zsh/ }
end
