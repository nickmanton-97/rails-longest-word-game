require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
        @letters = params[:letters].split(" ")
    @word    = params[:word].upcase

    if !included_in_grid?(@word, @letters)
      @message = "The word can't be built out of the grid ❌"
    elsif !english_word?(@word)
      @message = "The word is not a valid English word ❌"
    else
      @message = "Congratulations! You scored #{@word.length} points ✅"
    end
  end

  private

  def included_in_grid?(word, letters)
    word.chars.all? { |c| word.count(c) <= letters.join.count(c) }
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = URI.open(url).read
    JSON.parse(response)["found"]  # true if valid
  rescue
    false
  end
end
