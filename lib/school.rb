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
      page = Nokogiri::HTML(open(school_HTML, 'User-Agent' => 'firefox'))
      schools = page.css(".search-result-content")
      schools.each { |school|
        @name = school.children[1].children[1].children[1].children.text
        @zip = zip
        @district = school.children[1].children[3].children[3].children.text
        @ranking = school.children[1].children[5].children[3].children.text
        @rank = /\#[0-9]+/.match(@ranking.to_s)[0].slice(1..-1)
        @description = school.children[3].children[1].children.text
        @grad_rate = schools.css(".show-for-small-only")[0].children[1].children[1].children.text
        @readiness = schools.css(".show-for-small-only")[0].children[3].children[1].text
        test_hash = { :name => @name, :rank => @rank }
        if !@@summary.include? test_hash
          @@summary << test_hash
        end
        test_hash = { :name => @name, :zip => @zip, :district => @district, :rank => @rank, :description => @description,
          :grad_rate => @grad_rate, :readiness => @readiness }
        if !@@list.include? test_hash
          @@list << test_hash
        end
      }
    end
  end

  def self.summary
    @@summary
  end

  def self.list
    @@list
  end
#  binding.pry
end
