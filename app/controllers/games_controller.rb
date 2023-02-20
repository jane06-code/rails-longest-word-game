require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    # build the letter
    @letters = Array.new(10) { ('a'..'z').to_a[rand(26)] }
    @letters.shuffle!
  end

  def score
    # retrieve game data from form
    # @letters = params [:letter].split('')

    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  # private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
