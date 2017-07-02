require 'spec_helper'

describe command("bash -lc \"which pyenv\"") do
  its(:exit_status) { should eq 0 }
end

describe command("zsh -lc \"which pyenv\"") do
  its(:exit_status) { should eq 0 }
end

describe command("bash -lc \"pyenv versions\"") do
  its(:stdout) { should match /2.7.13/ }
end

describe command("bash -lc \"pyenv versions\"") do
  its(:stdout) { should match /3.6.1/ }
end
