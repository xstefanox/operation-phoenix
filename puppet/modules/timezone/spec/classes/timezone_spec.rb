require 'spec_helper'

describe 'timezone' do
  ['Debian','RedHat','Gentoo'].each do |osfamily|
    describe "on supported osfamily: #{osfamily}" do
      include_examples osfamily
    end
  end
end
