require "spec_helper"
require_relative "../lib/school.rb"

describe 'School' do

  it 'creates a new school object' do
    school = School.new(nil)
    expect(school.class).to eq(School)
  end
end
