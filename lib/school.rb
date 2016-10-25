require 'pry'
require 'nokogiri'
require 'open-uri'

class School

  attr_reader :list
  attr_accessor 

  @@list = []
  @@summary = []

  def initialize(school_HTML, zip)
    if school_HTML != nil
      page = Nokogiri::HTML(open(school_HTML))
      schools = page.css(".search-result-content")
      schools.each { |school| 
        @name = school.children[1].children[1].children[1].children.text
        @zip = zip
        @district = school.children[1].children[3].children[3].children.text
        @ranking = school.children[1].children[5].children[3].children.text
        @rank = /\#[0-9]+/.match(@ranking.to_s)
        @description = school.children[3].children[1].children.text
        @grad_rate = schools.css(".show-for-small-only")[0].children[1].children[1].children.text
        @readiness = schools.css(".show-for-small-only")[0].children[3].children[1].text
        @@summary << { :name => @name, :rank => @rank }
        @@list << { :name => @name, :zip => @zip, :district => @district, :rank => @rank, :description => @description,
          :grad_rate => @grad_rate, :readiness => @readiness }
      }
    end
  end
  
end
