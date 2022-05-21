module SaveGame
  #def save_game
   # p "saving Game:"
 # end

  #json_saved = hash_save.to_json

  #p json_saved

  def save_to_file
  File.open("#{save_name}.txt", "w"){ |somefile| somefile.puts json_saved}
  end
end

module GettingInput
  def message_for_try
    p "pick a letter a - z or write 'save' to save the game"
  end

  def get_letter
    gets.chomp.downcase
  end

  def get_user_input
    loop do
    message_for_try
    move = get_letter
    next if !valid_input?(move) && dont_cheat
    break p move
  end
  end

  def valid_input?(input)
    input == "save" ||
    input.length == 1 &&
      input.match?(/[a-z]/) # [:alpha:] -> all alphanumeric, including non-unicode
  end

  def dont_cheat
    p "a LETTER, one, from A - Z. You can do it!"
  end

end

# Prep for game - random word, making it into hash and blank result hash 
class GamePrep
  FILE = File.open('english_words.txt', 'r')

  attr_accessor :word, :secret_hash, :blank_guess

  def initialize
    @word = ""
    @secret_hash = {}
    @blank_guess = {}
  end

  def get_word (number)
    count = 0
    
    until count == number
      p "#{count} #{FILE.gets}"
      count += 1
    end
    line = FILE.gets
    p line
  end

  def check_word(word, number)
    until p (6..13).include?(word.length)
      p word
      FILE.rewind
      number += 1
      word = get_word(number)
    end
    p word
    self.word = word.chomp
  end
  
  def random_number
    rand(1..400)
  end

  def word_to_hash
    split_word = word.split("")
    p split_word
    split_word.map.with_index { | letter, idx |
      [idx, letter] }.to_h
  end

  def set_secret_hash
    self.secret_hash = word_to_hash
  end  

  def mask_letters
    secret_hash.map {| key, value |
      value = "_"}.join("")
  end

  def set_blank_guess
    self.blank_guess = mask_letters
  end

  def game_prep
    num = random_number # might add pick number
    word = get_word(num)
    check_word(word, num)
    #p set_secret_hash
    #p set_blank_guess
  end


  p "Game_prep initalized"
end

class Game
  include GettingInput
  include SaveGame

  attr_accessor :current_result, :tried_letters, :matched, :round_count
  attr_reader :secret_hash

  def initialize(secret_hash, current_result, tried_letters = [], round_count = 0)
    # @secret_word = secret_word
    @secret_hash = secret_hash
    @current_result = current_result
    @tried_letters = tried_letters
    @matched = {}
    @round_count = round_count
  end

  def round_count_check
    self.round_count += 1
    p round_count
    round_count < 6
  end

  def get_input_letter
    try = get_user_input
    unless try == "save" 
      self.tried_letters << try
    end
    try
  end


  def check_for_match(try_letter)
    if secret_hash.values.include?(try_letter)
     self.matched = secret_hash.select do | key_, value |
     value == try_letter
     end
    else
     false
    end
  end

  def update_current_result
   p current_result
   p matched
   matched.reduce(current_result) do | new_result, (k,v) |
   new_result[k] = v # changes Array outside of method's scope
   p new_result
   end
   p current_result
  end

  def print
   p "printng"
   p secret_hash
   p current_result
   p tried_letters
   p matched
  end

  def playing_game
    while round_count_check do # add win condition for end-game
      get_input = get_input_letter
      if get_input == "save"
        save_game
        p "thanks for a game"
        break
      else
      check_for_match(get_input) && update_current_result
      print
      end
    end
  end

  def export_game
    {:secret_hash => secret_hash,
    :current_result => current_result,
    :tried_letters => tried_letters,
    :round_count => round_count}
  end


  def save_game
    p "saving Game, input a save name:"
    #p export_game.to_json
    filename = "#{get_letter}.txt"
    File.open(filename, "w") do |file|
      file.puts JSON.dump(export_game)
    end
  end

  def load_game(saved_file)
    load_game = File.read(saved_file)
    parsed_load_game = JSON.parse(load_game)
    load_secret_hash = parsed_load_game["secret_hash"].map {|k, v| [k.to_i, v]}.to_h
    loaded = Game.new(load_secret_hash, parsed_load_game["current_result"], parsed_load_game["tried_letters"], parsed_load_game["round_count"])
    p parsed_load_game["current_result"]
    loaded.playing_game
  end



  
  p "Game initalized"
end

#new game:
def start_new_game
  w = GamePrep.new
  w.game_prep

  new_game = Game.new(w.set_secret_hash, w.set_blank_guess)
  p "new Game!"
  new_game.playing_game
end

  def load_game(saved_file)
    load_game = File.read(saved_file)
    parsed_load_game = JSON.parse(load_game)
    load_secret_hash = parsed_load_game["secret_hash"].map {|k, v| [k.to_i, v]}.to_h
    loaded = Game.new(load_secret_hash, parsed_load_game["current_result"], parsed_load_game["tried_letters"], parsed_load_game["round_count"])
    p parsed_load_game["current_result"]
    loaded.playing_game
  end

  def get_letter
    gets.chomp.downcase
  end

def run_program
  p "do you want to start a new game or load game? - N for new game - Load fro load"
  user_game = get_letter
  case user_game 
  when "n" then start_new_game
  when "load" 
    p "state name of game you want to load" 
    save_name = get_letter
    load_game(save_name)
  end
end
  
run_program
# add the above to the classes, "new game class" -> and then chose what you want to do

