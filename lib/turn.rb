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

  def computer_fires_upon_cell
    fire_location = @computer.query_fire_upon
    @player_board.cells[fire_location].fire_upon
  end

end
