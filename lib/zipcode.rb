require 'pry'
require 'nokogiri'
require 'open-uri'

class ZipCode
  attr_accessor :zip, :demo
  attr_reader :valid

@@valid = File.open("zips.txt").readlines.each { |zip| zip.chomp! }
@@all = []

  def initialize(zip)
    #@valid = File.open("zips.txt").readlines.each { |zip| zip.chomp! }
    setZip(zip)
    @range = []
    if !ZipCode.all.detect { |zipcode| zipcode.zip == @zip }
      @@all << self
    end
  end

  def setZip(zip)
    while !@@valid.include?(zip)
      puts "That zip code is invalid, please enter a new one"
      zip = gets.chomp!
    end
    @zip = zip
    demographics(zip)
  end

  def range
    @range
  end

  def demographics(zip)
#    binding.pry
    #html = "http://zipwho.com/?zip=#{zip}&city=&filters=--_--_--_--&state=&mode=zip"
    html = "http://neighborhoodlink.com/zip/#{zip}"
    page = Nokogiri::HTML(open(html))
    #if page.css("body").children.text == "?"
    #    puts "Web site down - please try again later"
    #    exit
    #end
    #binding.pry
    #data = page.css("html head script").children[0].text
    results = []
    data = page.css("#economics li")
    for i in 1..data.size - 1
      results[i] = data[i].text
    end
    
    #results = data.match(/\"[a-zA-Z\,]+/)[0].slice(1..-1)
    
    #keys = results.split(",")
    #values = data.to_s.match(/[0-9]{5}[a-zA-Z0-9, .]+/)[0].split(',')
    @demo = {}
    for i in 1..results.size - 1
      #binding.pry
      key, value = results[i].split(":")
      @demo[key] = value
    end
  end

  def getRange(zip, radius, income)
    html = "https://www.zip-codes.com/zip-code-radius-finder.asp?zipmileslLow=0&zipmileshigh=#{radius}&zip1=#{zip}&submit=Search"
    page = Nokogiri::HTML(open(html))
    children_size = page.css("#tableview table tr td").children.children.size
    counter = 1
    while counter < children_size
      newZip = ZipCode.new(page.css("#tableview table tr td").children.children[counter].text)
      #binding.pry
      if newZip.demo["MedianIncome"].to_i <= income
        @range << newZip
      end
      counter += 3
    end
  end

  def self.all
    @@all
  end

end

#test = ZipCode.new("11710")
#test.demographics(test.zip)
#binding.pry
