module SaveGame


end
module GettingInput
  def message_for_try
    p "pick a letter a - z"
  end

  def get_letter
    p message_for_try
    gets.chomp.downcase
  end

  def get_user_input
    loop do
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


  p "Game_prep initalized"
end

class Game
  include GettingInput
  include SaveGame

  attr_accessor :current_result, :tried_letters, :matched, :round_count
  attr_reader :secret_hash

  def initialize(secret_hash, current_result, tried_letters = [], round_count = 1)
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
      if try == "save"
        save_game 
      else
    self.tried_letters << try
    try
      end
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
   p matched
   matched.reduce(current_result) do | new_result, (k,v) |
   new_result[k] = v
   p new_result
   end
  end

  def print
   p "prinitng"
   p secret_hash
   p current_result
   p tried_letters
   p matched
  end


  
  p "Game initalized"
end

  w = GamePrep.new
  num = w.random_number
  word = w.get_word(num)
  w.check_word(word, num)
  p w.set_secret_hash
  p w.set_blank_guess

  new_game = Game.new(w.set_secret_hash, w.blank_guess)
  p "new Game!"
  while new_game.round_count_check do
  get_input = new_game.get_input_letter
  new_game.check_for_match(get_input) && new_game.update_current_result
  new_game.print
  end