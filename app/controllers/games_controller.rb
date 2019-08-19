require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    input = params[:word]
    @letters = params[:grid]
    filepath = "https://wagon-dictionary.herokuapp.com/#{input}"
    results = open(filepath).read
    @word = JSON.parse(results)
    if @word['found'] == true && input.chars.all? { |char| @letters.include? char }
      @result = "Congratulations, #{@word['word']} is a valid word"
    elsif @word['found'] == false
      @result = "Sorry, #{@word['word']} is not a valid English word"
    else
      @result = "Sorry, #{@word['word']} can't be built out of #{@letters}"
    end
  end
end
