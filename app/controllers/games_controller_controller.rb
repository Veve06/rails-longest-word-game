class GamesControllerController < ApplicationController
  def new
    @letters = generate_grid(6)
  end

  def generate_grid(grid_size)
   Array.new(grid_size) { ('A'..'Z').to_a.sample }
  end


def included?(guess, grid)
  guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
end


def english_word?(word)
  response = open("https://wagon-dictionary.herokuapp.com/#{word}")
  json = JSON.parse(response.read)
  return json['found']
end


  def score
    @letterss = params[:letters]
    @name = params[:name]

  if included?(@name.upcase, @letterss)
    if english_word?(@name)

      @result = [score, "well done"]
    else
      @result =[0, "not an english word"]
    end
  else
   @result = [0, "not in the grid"]
  end
end


end
