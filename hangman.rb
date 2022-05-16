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

#def check_word(word)
p word.length
 until p (6..13).include?(word.length)
    p word
#else
    file.rewind
    number += 1
    word = get_word(number, file)
end
p word
#end

#p words_file