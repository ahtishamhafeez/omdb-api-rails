
class Movie < ApplicationRecord

  def self.search_movie(query)
    @movie= query
    @movieFromDb = Movie.where('title LIKE ?', "%#{@movie}%")

    # There are two ways to do the task ,
    # 1- Implementing the native http request or raisl application    code is commented from lin-12
    # 2- Implementing Json Parser

    # Below is the code that  is used to get response using rails native http requests
    # binding.pry
    # uri= URI.parse("http://www.omdbapi.com?s=#{@movie}")
    #
    # http = Net::HTTP.new(uri.host, uri.port)
    # request = Net::HTTP::Get.new(uri.request_uri)
    # @response = http.request(request)
    #
    # results=@response.body
    #
    # binding.pry
    #
    # results.each do |record|
    #
    # end

    json = JSON.parse(open("http://www.omdbapi.com?s=#{@movie}") { |x| x.read }).first

    #  Above code is to get the response from the API and read the record from JSON Array to get the results

    # binding.pry    use this for debugging from console
if json[1]== "False"
    puts "-----------------Error-------------------"
else
    data = json.last
    # binding.pry
    @record = Array.new
    # Array To Store the full record
    @newRecordFromApi =  Array.new
    # Array To Store the new record
    @oldRecordFromDatabase = Array.new
    # Array To Store the database
    # binding.pry
    if(data)
      data.each do |fetch|
        # binding.pry
        @record << fetch
        movie  =  Movie.find_or_initialize_by(title:fetch["Title"],year:fetch["Year"],image:fetch["Poster"])
        #Here we will check that the record is new or old if new Then We will move the record into the @newRecordFromApi Array

        if movie.new_record?
          movie.save!
          @newRecordFromApi << fetch
          # binding.pry
          puts "************ This is New Record ************* "
        else
          #Here we will check that the record is new or old if old Then We will move the record into the @oldRecordFromDatabase Array
          @oldRecordFromDatabase << movie
          puts "************ This is and Old Record *************"

        end
       #Get the eache response valu by Name Year Poster
        puts "Name :"+fetch["Title"]
        puts "Year :"+fetch["Year"]
        puts "Poster :"+fetch["Poster"]
      end
      @oldRecordFromDatabase = @oldRecordFromDatabase | @movieFromDb
    end
    puts"--------------------Record Retrurn#{data.size}"
    puts "-------------------------------Total Record Run  #{Movie.all.size}"
    # binding.pry

    #Made the All three response as hash to get access this response collectively in the controller of this class
    @response= Hash["record"=>@record,"newRecordFromApi"=>@newRecordFromApi,"oldRecordFromDatabase"=>@oldRecordFromDatabase]
    return   @response
    # binding.pry
    # puts response.body
  end
  end


end
