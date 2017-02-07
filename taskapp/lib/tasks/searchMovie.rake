task :searchMovie => :environment do

  require 'open-uri'
  input = ''
  STDOUT.puts "Enter Movie to Search"
  input = STDIN.gets.chomp
  json = JSON.parse(open("http://www.omdbapi.com?s=#{input}") { |x| x.read }).first
  data = json.last
  # binding.pry
  @record = Array.new
  @newRecordFromApi =  Array.new
  @oldRecordFromDatabase = Array.new
  # binding.pry
  if(data)
    data.each do |v|
      @record << v
      movie  =  Movie.find_or_initialize_by(title:v["Title"],year:v["Year"],image:v["Poster"])
      if movie.new_record?
        movie.save!
        @newRecordFromApi << movie
        puts "************ This is New Record ************* "
      else
        @oldRecordFromDatabase << movie
        puts "************ This is and Old Record *************"
      end
      # Movie.exists?(a)
      # Movie.create(title:v["Title"],year:v["Year"],image:v["Poster"])
      puts "Name :"+v["Title"]
      puts "Year :"+v["Year"]
      puts "Poster :"+v["Poster"]
      # end
    end
  end

  puts"--------------------Record Retrurn#{data.size}"
  puts "-------------------------------Total Record Run  #{Movie.all.size}"

   # raise " Please Enter At Least one Character" unless input == ""

end

