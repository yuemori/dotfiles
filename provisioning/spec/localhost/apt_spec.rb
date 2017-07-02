require 'spec_helper'

describe command('which ghq') do
  its(:exit_status) { should eq 0 }
end

describe command('which peco') do
  its(:exit_status) { should eq 0 }
end
