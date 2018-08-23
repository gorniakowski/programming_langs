## Solution template for Guess The Word practice problem (section 7)

require_relative './section-7-provided'

class ExtendedGuessTheWordGame < GuessTheWordGame
  def initialize secret_word_class
    super
    @prev_guess =[]
  end

  def no_prev_guess letter
    n=Regexp.new(letter,Regexp::IGNORECASE)
    if @prev_guess.index{|e| e =~ n}
      false
    else
      @prev_guess<< letter
      true
    end
  end
  def ask_for_guessed_letter
    puts "Secret word:"
    puts @secret_word.pattern
    puts @mistakes_allowed.to_s + " incorrect guess(es) left."
    puts "Enter the letter you want uncovered:"
    letter = gets.chomp
    if @secret_word.valid_guess? letter and no_prev_guess letter
      if !@secret_word.guess_letter! letter
        @mistakes_allowed -= 1
        @game_over = @mistakes_allowed == 0
      else
        @game_over = @secret_word.is_solved?
      end
    else
      puts "I'm sorry, but that's not a valid letter."
    end
  end
end

class ExtendedSecretWord < SecretWord
  def initialize word
    self.word = word
    self.pattern = self.word.each_char.map {|chr| if chr =~ /[a-zA-Z]/ then chr="_" else chr end }.join
  end

  def valid_guess? guess
    if guess.length == 1 and guess=~ /[a-zA-Z]/
      true
    else
      false
    end
  end

  def guess_letter! letter
    r=Regexp.new(letter,Regexp::IGNORECASE)
    found = self.word.index r
    if found
      start = 0
      while ix = self.word.index(r, start)
        self.pattern[ix] = self.word[ix]
        start = ix + 1
      end
    end
    found
  end

end

## Change to `false` to run the original game
if true
  ExtendedGuessTheWordGame.new(ExtendedSecretWord).play
else
  GuessTheWordGame.new(SecretWord).play
end
