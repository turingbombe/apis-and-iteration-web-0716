#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
choice = selection
if choice == 1
    character = get_character_from_user
    show_character_movies(character)
elsif choice == 2
    movie = get_movie_from_user
    show_movie_characters(movie)
else
    puts "Sorry - that is not a correct selection"
end
