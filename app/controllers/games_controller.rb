require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...9).map { rand(65..90).chr }
  end

  def score
    grid = params[:letters].split
    attempt = params[:attempt]

    def attempt_grid(attempt, grid)
      attempt.upcase.chars.each do |letter|
        if grid.include?(letter)
          grid.delete_at(grid.index(letter))
        else
          return false
        end
      end
    end

  url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
  dictionary_serialized = URI.open(url).read
  word_data = JSON.parse(dictionary_serialized)

  if word_data["found"] && attempt_grid(attempt, grid)
    @score = attempt.length
    @message = "well done"
  elsif word_data["found"]
    @score = 0
    @message = "not in the grid"
  else
    @score = 0
    @message = "not an english word"
  end
  end
end
