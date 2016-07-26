def welcome
  # puts out a welcome message here!
  puts "Find out some more about Star Wars!"
end

def selection
  puts "What do you want to search?"
  puts "Characters - Enter 1"
  puts "Movies - Enter 2"
  gets.chomp.to_i   
end

def get_character_from_user
  puts "please enter a character name"
  # use gets to capture the user's input. This method should return that input, downcased.
  gets.chomp.downcase 
end

def get_movie_from_user
  puts "please enter a movie name"
  # use gets to capture the user's input. This method should return that input, downcased.
  gets.chomp.downcase
end