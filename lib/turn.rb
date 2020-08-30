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
    puts "=============COMPUTER BOARD============="
    @computer_board.render
  end

  def print_player_board
    puts "==============PLAYER BOARD=============="
    @player_board.render
  end

end
