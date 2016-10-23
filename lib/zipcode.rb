class ZipCode
  attr_accessor :zip
  attr_reader :valid

  def initialize(zip)
    @zip = zip
    #File.readlines("../zips.txt").each { |zip| @valid << zip.chomp! }
    @valid = File.open("zips.txt").readlines.each { |zip| zip.chomp! }
  end

end
