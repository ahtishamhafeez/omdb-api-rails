require "net/http"
require 'json'
# The headers require for the JSON and HTTP request
class MovieController < ApplicationController
  def index
    @movies = Movie.all
  end
  def new
  end
  def create
  end

  def delete
  end

  def update

  end
  # All Above functions were made for manuipulation with database if it was required.
  def search
    #commented code is when i was testing the code by using controller method

    # @movie= params[:q];
    #
    # # binding.pry
    # # uri= URI.parse("http://www.omdbapi.com?s=#{@movie}")
    # #
    # # http = Net::HTTP.new(uri.host, uri.port)
    # # request = Net::HTTP::Get.new(uri.request_uri)
    # # @response = http.request(request)
    # #
    # # results=@response.body
    # #
    # # binding.pry
    # #
    # # results.each do |record|
    # #
    # # end
    #
    # json = JSON.parse(open("http://www.omdbapi.com?s=#{@movie}") { |x| x.read }).first
    #
    # data = json.last
    #
    # # binding.pry
    #
    # @record = Array.new
    # @newRecordFromApi =  Array.new
    # @oldRecordFromDatabase = Array.new
    #
    # # binding.pry
    #
    # if(data)
    #
    # data.each do |v|
    #   # binding.pry
    #   # v.each do |record|
    #   @record << v
    #   # movie = Movie.new(title:v["Title"],year:v["Year"],image:v["Poster"])
    #
    #   # binding.pry
    #
    #   # movie =  Movie.exists?(title:v["Title"],year:v["Year"],image:v["Poster"])
    #
    #
    #   # object.new_record? This is the method that canbe used if the record is new
    #   # if(movie.new_record?)
    #   #
    #   # end
    #   #   binding.pry
    #  movie  =  Movie.find_or_initialize_by(title:v["Title"],year:v["Year"],image:v["Poster"])
    #   if movie.new_record?
    #
    #
    #       movie.save!
    #       @newRecordFromApi << movie
    #
    #
    #      puts "************ This is New Record ************* "
    #
    #   else
    #
    #      @oldRecordFromDatabase << movie
    #
    #     puts "************ This is and Old Record *************"
    #
    #   end
    #
    #   # Movie.exists?(a)
    #
    #
    #
    #   # Movie.create(title:v["Title"],year:v["Year"],image:v["Poster"])
    #
    #      puts "Name :"+v["Title"]
    #      puts "Year :"+v["Year"]
    #      puts "Poster :"+v["Poster"]
    #    # end
    #
    # end
    #
    #   binding.pry
    # end
    #
    # puts"--------------------Record Retrurn#{data.size}"
    # puts "-------------------------------Total Record Run  #{Movie.all.size}"
    #
    # # binding.pry
    #
    # render status: 200    , template: 'movie/index'
    #
    # # binding.pry
    # # puts response.body

    response=Movie.search_movie(params[:q])
    # response is  to be used as local variable
      # if( response[:error].present?)
      #   redirect_to()
      # end

    @newRecordFromApi=response['newRecordFromApi']
    @oldRecordFromDatabase=response['oldRecordFromDatabase']
    @record=response['record']
    render status: 200    , template: 'movie/index'
  end
  # Below function is only  for use in this controller that's why this is private
  private
  def set_attributes
    params.permit(:title,:year,:director,:image)
  end

end
