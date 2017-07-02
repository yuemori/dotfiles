require 'spec_helper'

describe command('bash -lc "which rbenv"') do
  its(:exit_status) { should eq 0 }
end

describe command('zsh -lc "which rbenv"') do
  its(:exit_status) { should eq 0 }
end

describe command('zsh -lc "rbenv versions"') do
  its(:stdout) { should match /2.4.1/ }
end
