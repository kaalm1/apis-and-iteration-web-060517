require 'rest-client'
require 'json'
require 'pry-byebug'

def get_character_movies_from_api(character)
  #make the web request
  next_website = 'http://www.swapi.co/api/people/'
  main_all_characters = {}
  begin
    all_characters = RestClient.get(next_website)
    character_hash = JSON.parse(all_characters)
    new_all_characters = character_hash["results"].each_with_object({}) do | temp_character, hsh|
      hsh[temp_character["name"].downcase] = temp_character["films"]
    end
    main_all_characters.merge!(new_all_characters)
    next_website = character_hash["next"]
  end while !next_website.nil?



  main_all_characters[character]
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.map! do |movie|
    all_info = RestClient.get(movie)
    info_hash = JSON.parse(all_info)
    info_hash["title"]
  end

  films_hash.each {|movie| puts movie}

end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)

end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
