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
    #binding.pry
    demographics(zip)
    #binding.pry
  end

  def range
    @range
  end

  def demographics(zip)
    @demo = {}
    html = "http://neighborhoodlink.com/zip/#{zip}"
    begin
      page = Nokogiri::HTML(open(html))
    rescue
      return
    end
    results = []
    data = page.css("#economics li")
    for i in 1..data.size - 1
      results[i] = data[i].text
    end
    for i in 1..results.size - 1
      key, value = results[i].split(":")
      @demo[key] = value
    end
  end

  def getRange(zip, radius, income)
    html = "https://www.zip-codes.com/zip-code-radius-finder.asp?zipmileslLow=0&zipmileshigh=#{radius}&zip1=#{zip}&submit=Search"
    #binding.pry
    page = Nokogiri::HTML(open(html))
    children_size = page.css("#tableview table tr td").children.children.size
    counter = 1
    while counter < children_size
      newZip = ZipCode.new(page.css("#tableview table tr td").children.children[counter].text)
      if newZip.demo.size > 0 && newZip.demo["Median Family Income"].gsub(/[$\, ]/,"").to_i <= income
        @range << newZip
      end
      counter += 3
    end
  end

  def self.all
    @@all
  end

end
