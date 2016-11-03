Gem::Specification.new do |s|
  s.name	= 'school-finder'
  s.veraion	= "1.0"
  s.date	= "2016-11-03"
  s.summary	= "Find highly ranked high schools"
  s.description	= "List the best high schools within a given zip code radius"
  s.authors	= ["Ray Mulligan"]
  s.email	= 'rmullig2@optonline.net'
  s.files	= ["lib/schoolfinder.rb", "lib/school.rb", "lib/zipcode.rb", "lib/zips.txt", "config/environment.rb", "README.md", "spec.md"]
  s.executables	<< 'school-finder'
  s.homepage	= "https://github.com/rmullig2/school-finder-cli"
  s.license	= 'MIT'
end
