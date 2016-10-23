require "spec_helper"
require_relative "../lib/zipcode.rb"

describe 'ZipCode' do

  it 'creates a new zip code object' do
    zipcode = ZipCode.new(11710)
    expect(zipcode.zip).to eq(11710)
  end
end
