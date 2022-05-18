module Getting_input
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
    input.length == 1 &&
      input.match?(/[a-z]/) # [:alpha:] -> all alphanumeric, including non-unicode
  end

  def dont_cheat
    p "a LETTER, one, from A - Z. You can do it!"
  end

end

class Game_prep
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
      value = "_"}.join(" ")
  end

  def set_blank_guess
    self.blank_guess = mask_letters
  end


  p "Game_prep initalized"
end

class Game
  include Getting_input

  attr_accessor :hash_result
  attr_reader :secret_hash

  def initialize(secret_hash, hash_result)
    #@secret_word = secret_word
    @secret_hash = secret_hash
    @hash_result = hash_result
  end

  def check_move(move)

  end

  def current_state(secret_hash)

  end

  def print
    p "Game"
    p secret_hash
    p hash_result
  end


  
  p "Game initalized"
end


w = Game_prep.new
num = w.random_number
word = w.get_word(num)
w.check_word(word, num)
p w.set_secret_hash
p w.set_blank_guess

new_game = Game.new(w.set_secret_hash, w.blank_guess)
p "new Game!"
new_game.get_user_input

new_game.print