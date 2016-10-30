require_relative "./zipcode"
require_relative "./school"
require 'pry'

class SchoolFinder

  attr_accessor :zip, :zipcode, :miles, :income, :results, :summary, :detail

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
      if value != 0
        @income = value
      else
        @income = 10000000
      end
    when "results"
      while value < 0
        puts "Please enter a number greater than zero or hit enter to accept the default value"
        value = gets.chomp.to_i
      end
      if value
        @results = value
      else
        @results = 50
      end
    end
  end

  def school_list
    #@results != 0 ? @zipcode.getRange(@zipcode.zip, @miles, @results) : @zipcode.getRange(@zipcode.zip, @miles)
    @zipcode.getRange(@zipcode.zip, @miles, @income)
    zipcodes = @zipcode.range
    binding.pry
    zipcodes.each { |zipcode| School.new("http://www.usnews.com/education/best-high-schools/search?city-or-zip=#{zipcode.zip}", zipcode) }
    @summary = School.summary
    @summary.sort_by! { |school| [school[:rank] ? 0 : 1, school[:rank] || 0] }
    @detail = School.list
    @detail.sort_by! { |school| [school[:rank] ? 0 : 1, school[:rank] || 0] }
    binding.pry
    display_schools
  end

  def display_schools
    total = summary.size - 1 < results ? summary.size - 1 : results
    for i in 0..total - 1 do
      if summary[i][:rank]
        puts "##{i+1}. #{summary[i][:name]} - rank #{summary[i][:rank]}"
      else
        puts "##{i+1}. #{summary[i][:name]} - no ranking"
      end
    end
  end

  def filter_income

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
