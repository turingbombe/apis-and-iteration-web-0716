require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  url = 'http://www.swapi.co/people/'
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  if character_hash["results"][0]["name"].downcase == character
    films_hash = character_hash["results"][0]["films"]
  end
end

def parse_character_movies(films_hash)
  films_hash.each do |film|
    new_all_characters = RestClient.get(film)
    new_film_hash = JSON.parse(new_all_characters)
    puts new_film_hash["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end
