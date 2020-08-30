require './lib/game'
require './lib/computer'
require './lib/board'

class Turn
  attr_reader :computer, :player
  def initialize(player, computer, player_board, computer_board)
    @player = player
    @computer = computer
    @player_board = player_board
    @computer_board = computer_board
  end

  def print_computer_board
    @computer_board.render
  end

  # def print_player_board
  #   game.player_board.render
  #   require "pry"; binding.pry
  # end


end
