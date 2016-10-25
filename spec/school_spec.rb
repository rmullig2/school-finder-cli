require "spec_helper"
require_relative "../lib/school.rb"

describe 'School' do

  it 'creates a new school object' do
    school = School.new(nil)
    expect(school.class).to eq(School)
  end
  
  it 'creates a school object from XML' do
    xml_school = File.read("spec/test.xml")
    school = School.new("http://www.usnews.com/education/best-high-schools/search?city-or-zip=11710")
    expect(school.class).to eq(School)
  end
  
end
