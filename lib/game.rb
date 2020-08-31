require './lib/turn'

class Game
  attr_reader :answer, :player, :computer, :player_board, :computer_board, :player_cruiser, :player_submarine, :computer_cruiser, :computer_submarine

  def initialize
    @answer = ""
    @player = Player.new("Timmy")
    @computer = Computer.new
    @player_board = Board.new
    @computer_board = Board.new
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
  end

  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter 'p' to play. Enter 'q' to quit."
    @answer = gets.chomp.downcase
    if @answer == "p"
      run_game
    elsif @answer == "q"
      puts "Come back and play sometime!"
    else
      until @answer == "p" || @answer == "q"## || 3.times
        puts "Please enter 'p' to start a game or 'q' to quit."
        @answer = gets.chomp.downcase
        if @answer == "p"
          run_game
        elsif @answer == "q"
          puts "Come back and play sometime!"
        end
      end
    end
  end

  def computer_place_ships
    computer_cruiser_placement = computer.query_place_ship(@computer_cruiser.length)
    @computer_board.place(@computer_cruiser, computer_cruiser_placement)
    computer_submarine_placement = computer.query_place_ship(@computer_submarine.length)
    until @computer_board.valid_placement?(@computer_submarine, computer_submarine_placement)
      computer_submarine_placement = computer.query_place_ship(@computer_submarine.length)
    end
    @computer_board.place(@computer_submarine, computer_submarine_placement)
  end

  def player_place_ships
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts @player_board.render
    print"Enter the squares for the Cruiser (3 spaces):\n>  "
    player_cruiser_placement = player.query_place_ship
    until player_cruiser_placement.length == 3 && @player_board.valid_placement?(@player_cruiser, player_cruiser_placement)
      puts "Please select valid coordinates. Enter 3 coordinates separated by a space."
      player_cruiser_placement = player.query_place_ship
    end
    @player_board.place(@player_cruiser, player_cruiser_placement)
    puts @player_board.render(true)
    print "Enter the squares for the Submarine (2 spaces):\n>  "
    player_submarine_placement = player.query_place_ship
    until player_submarine_placement.length == 2 && @player_board.valid_placement?(@player_submarine, player_submarine_placement)
      puts "Please select valid coordinates. Enter 2 coordinates separated by a space that are empty."
      player_submarine_placement = player.query_place_ship
    end
    @player_board.place(@player_submarine, player_submarine_placement)
    puts @player_board.render(true)
  end

  def game_over?
    @player_cruiser.sunk? && @player_submarine.sunk? || @computer_cruiser.sunk? && @computer_submarine.sunk?
  end

  def end_game
    if @computer_cruiser.sunk? && @computer_submarine.sunk?
      "You win!"
    elsif @player_cruiser.sunk? && @player_submarine.sunk?
      "I win!"
    end
  end

  def turn
    Turn.new(player, computer, player_board, computer_board)
  end

  def run_game
    computer_place_ships
    player_place_ships
    until game_over?
      new_turn = turn()
      new_turn.run_turn(@computer_cruiser, @computer_submarine)
    end
    puts end_game
  end


end
