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

  attr_accessor :word

  def initialize
    @word = ""
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

  p "Game_prep initalized"
end

class Game
  include Getting_input

  attr_accessor :secret_hash
  attr_reader :secret_word

  def initialize(secret_word = "")
    @secret_word = secret_word
    @secret_hash = ""
  end

  def word_to_hash(secret_word)
    split_word = secret_word.split("")
    p split_word
    split_word.map.with_index { | letter, idx |
      [idx, letter] }.to_h
  end

  def set_secret_hash
    self.secret_hash = word_to_hash(secret_word)
  end

  def print
    p secret_hash
  end

  
  p "Game initalized"
end


w = Game_prep.new
num = w.random_number
word = w.get_word(num)
word_export = w.check_word(word, num)
p word_export

new_game = Game.new(word_export)
p "pozniej"
new_game.get_user_input
new_game.set_secret_hash
new_game.print