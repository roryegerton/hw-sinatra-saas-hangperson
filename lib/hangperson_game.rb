class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word, :guesses, :wrong_guesses

  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(letter)
    raise ArgumentError if letter !~ /[A-Za-z]/ 

    letter.downcase!

    return false if @guesses.include?(letter) || @wrong_guesses.include?(letter)

    if @word.include?(letter)
      @guesses << letter
    else
      @wrong_guesses << letter
    end
  end

  def word_with_guesses
    return_word_with_guesses = ""

    @word.chars.each do |letter|
      if @guesses.include?(letter)
        return_word_with_guesses += letter
      else
        return_word_with_guesses += "-"
      end
    end
  
    return_word_with_guesses
  end

  def check_win_or_lose
    if @wrong_guesses.length == 7
      return :lose
    elsif word_with_guesses.chars.include?("-")
      return :play
    else
      return :win
    end  
  end
end
