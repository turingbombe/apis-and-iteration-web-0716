require 'rest-client'
require 'JSON'
require 'pry'
def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  # iterate ove the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film. 
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list 
  #  of movies by title. play around with puts out other info about a given film.
  x = 0
  while x < character_hash["results"].length-1
    if character_hash["results"][x]["name"].downcase == character
      films_hash = character_hash["results"][x]["films"]
    end
    x += 1
  end

  collect_movie_data(films_hash)
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  print_hash = {}
  films_hash.each do |k|
    print_hash[k["episode_id"]] = k["title"]
  end
  print_hash = print_hash.sort_by{|k,v| k}
  print_hash.each {|k,v| puts "Episode #{k} #{v}"}
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
def collect_movie_data(films_hash)
  films_hash.collect do |film|
    all_films = RestClient.get(film)
    JSON.parse(all_films)
  end
end