require 'spec_helper'

describe command('brew bundle check --file=~/dotfiles/Brewfile') do
  its(:exit_status) { should eq 0 }
end
