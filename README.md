# hangman
hangmen from TOP
[dodac file.pos zeby sprawdzic czy pozycja 'kursora' sie resetuje]
chosing word: file.read('')
establish format - separate rows, array? (to.array(",")

loop -> until word.length(5<12)
secret_word=loop()

class game
@secret_word

-----
- assign key(number) to each letter of secret_word
- each time letter is picked scan the word and show keys[n] of matched letters
- update the hangman_array/string? with the picked letter for [n] indexes
-----

game class variables:
@secret_word
@hagnman_array/index
@missed_letters
@round