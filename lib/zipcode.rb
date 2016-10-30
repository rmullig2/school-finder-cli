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
  end

  def range
    @range
  end

  def demographics(zip)
    html = "http://zipwho.com/?zip=#{zip}&city=&filters=--_--_--_--&state=&mode=zip"
    page = Nokogiri::HTML(open(html))
    data = page.css("html head script").children[0].text
    results = data.match(/\"[a-zA-Z\,]+/)[0].slice(1..-1)
    keys = results.split(",")
    results = data.to_s.match(/\\n[0-9a-zA-Z\,\.]+/)
    values = results.to_s.slice(2..-1).split(",")
    @demo = {}
    for i in 0..keys.size - 1
      @demo[keys[i]] = values[i]
    end
  end

  def getRange(zip, radius, results = 50)
    html = "https://www.zip-codes.com/zip-code-radius-finder.asp?zipmileslLow=0&zipmileshigh=#{radius}&zip1=#{zip}&submit=Search"
    page = Nokogiri::HTML(open(html))
    children_size = page.css("#tableview table tr td").children.children.size
    counter = 1
    while counter < children_size && counter < results * 3 - 3
      @range << page.css("#tableview table tr td").children.children[counter].text
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
