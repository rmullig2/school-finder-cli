require 'pry'
require 'nokogiri'
require 'open-uri'

class ZipCode
  attr_accessor :zip, :demo
  attr_reader :valid

  def initialize(zip)
    @valid = File.open("zips.txt").readlines.each { |zip| zip.chomp! }
    setZip(zip)
    @range = []
    @range << self.zip
  end

  def setZip(zip)
    while !@valid.include?(zip)
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
    binding.pry
    @demo = {}
    for i in 0..keys.size - 1
      @demo[keys[i]] = values[i]
    end
  end

end

test = ZipCode.new("11710")
test.demographics(test.zip)
binding.pry
