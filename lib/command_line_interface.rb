def welcome
  # puts out a welcome message here!
  puts "Find out what movies your favorite Star Wars character was in!"
end

def get_character_from_user
  puts "please enter a character name"
  # use gets to capture the user's input. This method should return that input, downcased.
  gets.chomp.downcase 
end

