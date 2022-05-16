file = File.open('english_words.txt', 'r')
number = 39

def get_word (number, file)
count = 0

until count == number
  p "#{count} #{file.gets}"
  count += 1
    end
line = file.gets
p line

end

word = get_word(number, file)

def check_word(word)
p word.length
 until p (6..13).include?(word.length)
    p word

    file.rewind
    number += 1
    word = get_word(number, file)
end
p word
end

#p words_file


module Getting_input
  def 


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
    self.word = word
  end

  

    
end

class Game
  include Getting_input

  attr_accessor
  attr_reader

  def initialize(secret_word = "")
    @secret_word = secret_word
  end


end