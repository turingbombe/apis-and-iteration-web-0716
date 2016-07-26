require 'rest-client'
require 'JSON'
require 'pry'
def get_character_movies_from_api(character)
  #make the web request
  
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  while character_hash["next"] != nil
    all_characters = RestClient.get(character_hash["next"])
    new_hash = JSON.parse(all_characters)
    new_hash["results"].each do |k|
      character_hash["results"] << k
    end
    character_hash["next"] = new_hash["next"]
    character_hash["next"]
  end

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

def get_movie_characters_from_api(movie_name)
  all_movies = RestClient.get('http://www.swapi.co/api/films/')
  movies_hash = JSON.parse(all_movies)

  x = 0
  while x < movies_hash["results"].length-1
    if movies_hash["results"][x]["title"].downcase == movie_name
      characters_hash = movies_hash["results"][x]["characters"]
    end
    x += 1
  end
  collect_character_data(characters_hash)  
end

def show_movie_characters(movie_name)
  characters_hash = get_movie_characters_from_api(movie_name)
  parse_movie_characters(characters_hash)
end

def collect_character_data(characters_hash)
  characters_hash.collect do |character|
    all_characters = RestClient.get(character)
    JSON.parse(all_characters)
  end
end

def parse_movie_characters(characters_hash)
  # some iteration magic and puts out the movies in a nice list
  #print_hash = {}
  characters_hash.each do |k|
    #print_hash[k["episode_id"]] = k["title"]
    puts k["name"]
  end
  #print_hash = print_hash.sort_by{|k,v| k}
 # print_hash.each {|k,v| puts "Episode #{k} #{v}"}
end
