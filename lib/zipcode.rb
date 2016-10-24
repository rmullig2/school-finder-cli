class ZipCode
  attr_accessor :zip
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

end
