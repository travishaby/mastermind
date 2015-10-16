require 'pry'
# SETUP FOR GUESSES

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

def start_turn
  "Lets play!"
  turn
end

def read_instructions
  "Let me google that for you..."
end

def quit
  "Goodbye, thanks for playing!"
end

# SETUP FOR TURN

COLORS = ["r", "g", "b", "y"]

def correct_answer
  guesses
  @answer ||= COLORS.map {|x| COLORS.sample}.join
end

def guesses
  @guesses ||= 0
end

# LOGIC FOR TURN

def turn
  correct_answer
  puts "I have generated a beginner sequence with four elements made up of: (r)ed,
(g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to end the game. Please enter your guess as four sequential letters, for instance: 'rgby'.
What's your guess?"
  listen_to_response
end

def listen_to_response
  @user_guess = gets.chomp.downcase
  @user_guess == "q" ? quit : respond_to_guess(@user_guess)
end

def count_correct_position(comparison)
  @position_count = comparison.count {|color_pair| color_pair[0] == color_pair[1]}
end

def count_correct_characters(guess)
  answer_copy = @answer.dup.chars
  @character_count = answer_copy.count do |color|
    response = guess.include?(color)
    guess.shift
    response
  end
end

def respond_to_guess(guess)
  comparison = guess.chars.zip(correct_answer.chars)
  pos_count = count_correct_position(comparison)
  char_count = count_correct_characters(guess.chars)
  @guesses += 1
  unless @user_guess == @answer
    puts "'#{@user_guess}' has #{char_count} of the correct elements with #{pos_count} in the correct positions. You've taken #{@guesses} guess(es)."
    start_next_turn
  else
    win_game
  end
end

def start_next_turn
  puts "Please enter your guess as four sequential letters, for instance: 'rgby'.
  What's your guess?"
  listen_to_response
end

def win_game
  puts "Congratulations! You guessed the sequence '#{@answer}' in #{@guesses} guesses. Do you want to (p)lay again or (q)uit?"
  if gets == "p"
    @answer = nil
    @guesses = nil
    play_mastermind
  elsif gets == "q"
    quit
  else
    puts "Wtf!"
    win_game
  end
end

play_mastermind
