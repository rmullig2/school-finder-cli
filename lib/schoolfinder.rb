require_relative "./zipcode"
require 'pry'

class SchoolFinder

  attr_accessor :zip, :miles, :income

  def initialize
  end

  def call
    puts "Welcome to the School Finder application!"
    puts "Please enter a zip code from where you wish to search"
    @zip = gets.chomp!
    zipcode = ZipCode.new(@zip)
    #    binding.pry
    puts "Please enter the maximum search radius in miles (0-30)"
    @miles = gets.chomp.to_i
    check("miles", @miles)
    puts "Please enter your income (hit enter to skip this step)"
    @income = gets.chomp.to_i
    puts "Please enter the number of results you would like to see"
    results = gets.chomp.to_i
    puts "Zip = #{zipcode.zip}, miles = #{miles}, income = #{income}, results = #{results}"
  end

  def check(check_type, value)
    case check_type
    when "miles"
      while value < 0 || value > 30
        puts "Please input a number from 0 to 30"
        value = gets.chomp.to_i
      end
      @miles = value
    end
  end

# CLI for school finder app
# Welcome user (hit enter to exit)
# Ask for zip code
# Ask for search radius
# Ask for income (optional)
# Ask for number of results
#
# Print numbered list of schools
# Ask user if they want further details on one of the schools
#   If yes, then print further details on specified schhol
#     print numbered list of schools and prompt user again
#   If no, then go back to welcome user
end

test = SchoolFinder.new
test.call
