require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { Array('A'..'Z').sample }

  end

  def score
    @answer = params[:answer]
    @letters = params[:letters].split(" ")

    @include = include?(@answer,@letters)

    @english_word = english_word(@answer)

    # 1. The word can't be built out of the original grid
    if @include == false && @english_word == true
      @result = "Yay, your correct"

    # 2. The word is valid according to the grid, but is not a valid English word
    else
      if @include
        @result = "Your word is not a set of the letters!!"
      else
        @result = "Your word is not a English word!!!"
      end
    # 3. The word "is valid according to the grid and is an English word
    end
  end
  private
  def include?(answer,letters)
    array = answer.split("")
    array.each.map { |c| letters.include?(c)}.include?(false)
  end

  def english_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    answers = open(url).read
    hash = JSON.parse(answers)
    hash["found"]
  end
end
