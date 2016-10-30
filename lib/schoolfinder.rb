require_relative "./zipcode"
require_relative "./school"
require 'pry'

class SchoolFinder

  attr_accessor :zip, :zipcode, :miles, :income, :results

  def initialize
  end

  def call
    puts "Welcome to the School Finder application!"
    puts "Please enter a zip code from where you wish to search or enter to exit"
    @zip = gets.chomp!
    @zip.empty? && return
    @zipcode = ZipCode.new(@zip)
    puts "Please enter the maximum search radius in miles (0-30)"
    @miles = gets.chomp.to_i
    check("miles", @miles)
    puts "Please enter your income (hit enter to skip this step)"
    @income = gets.chomp.to_i
    check("income", @income)
    puts "Please enter the number of results you would like to see (default = 50)"
    @results = gets.chomp.to_i
    check("results", @results)
    school_list
  end

  def check(check_type, value)
    case check_type
    when "miles"
      while value < 0 || value > 30
        puts "Please input a number from 0 to 30"
        value = gets.chomp.to_i
      end
      @miles = value
    when "income"
      while value < 0
        puts "Please enter a number greater than or equal to zero"
        value = gets.chomp.to_i
      end
      @income = value
    when "results"
      while value < 0
        puts "Please enter a number greater than zero or hit enter to accept the default value"
        value = gets.chomp.to_i
      end
      @results = value
    end
  end

  def school_list
    @results != 0 ? @zipcode.getRange(@zipcode.zip, @miles, @results) : @zipcode.getRange(@zipcode.zip, @miles)
    zipcodes = @zipcode.range
    zipcodes.each { |zipcode| School.new("http://www.usnews.com/education/best-high-schools/search?city-or-zip=#{@zip}", @zip) }
    summary = School.summary
    detail = School.list
    binding.pry
  end

#
# Print numbered list of schools
# Ask user if they want further details on one of the schools
#   If yes, then print further details on specified schhol
#     print numbered list of schools and prompt user again
#   If no, then go back to welcome user
end

test = SchoolFinder.new
test.call
