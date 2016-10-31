require 'pry'
require 'nokogiri'
require 'open-uri'

class School

  attr_reader :list, :schools
  attr_accessor

  @@list = []
  @@summary = []

  def initialize(school_HTML, zip)
    if school_HTML != nil
      page = Nokogiri::HTML(open(school_HTML, 'User-Agent' => 'firefox'))
      @schools = page.css(".search-result-content")
      get_schoolinfo(zip)
    end
  end

  def get_schoolinfo(zip)
    @schools.each { |school|
      @name = school.children[1].children[1].children[1].children.text
      #@zip = ZipCode.new(zip).zip
      @zip = zip
      @district = school.children[1].children[3].children[3].children.text
      #binding.pry
      if school.children[1].children[5].children[3] == nil
        @rank = nil
      else
        @ranking = school.children[1].children[5].children[3].children.text
        @rank = /\#[0-9]+/.match(@ranking.to_s)
        if @rank
          @rank = @rank[0].slice(1..-1).to_i
        end
      end
      #binding.pry
      @description = school.children[3].children[1].children.text
      @grad_rate = schools.css(".show-for-small-only")[0].children[1].children[1].children.text
      @readiness = schools.css(".show-for-small-only")[0].children[3].children[1].text
      test_hash = { :name => @name, :rank => @rank }
      #binding.pry
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

  def self.summary
    @@summary
  end

  def self.list
    @@list
  end
#  binding.pry
end
