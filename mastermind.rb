
COLORS = ["g", "b", "y"]

def play_mastermind
  start_game
  read_response
end

def start_game
  puts "Welcome to MASTERMIND"
  puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
end

def read_response
  response = gets.chomp
  puts possible_responses[response]
end

def possible_responses
  {"p" => start_turn,
   "i" => read_instructions,
   "q" => quit}
end

# ----------------- 

def start_turn
  "Lets play!"
  turn
end

def read_instructions
  "what, you don't know how to play?"
end

def quit
  "ya done, son"
end

play_mastermind
