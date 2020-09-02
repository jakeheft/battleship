# require '../runner'
class Game
  attr_reader :player, :computer, :player_board, :computer_board, :player_cruiser, :player_submarine, :computer_cruiser, :computer_submarine

  def initialize
    @player = Player.new
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
    answer = gets.chomp.downcase
    if answer == "p"
      run_game
    elsif answer == "q"
      puts "Come back and play sometime!"
    else
      count = 0
      until answer == "p" || answer == "q" || count == 3
        puts "Please enter 'p' to start a game or 'q' to quit."
        answer = gets.chomp.downcase
        count += 1
        if answer == "p"
          run_game
        elsif answer == "q"
          puts "Come back and play sometime!"
        elsif count == 2
          print "Last chance! "
        end
      end
    end
  end

  def computer_place_ship(ship)
    computer_ship_placement = computer.query_place_ship(ship.length)
    until @computer_board.valid_placement?(ship, computer_ship_placement)
      computer_ship_placement = computer.query_place_ship(ship.length)
    end
    @computer_board.place(ship, computer_ship_placement)
  end

  def create_player_board_intro
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts @player_board.render
  end

  def player_place_ship(ship)
    print"Enter the squares for the #{ship.name} (#{ship.length} spaces):\n>  "
    player_ship_placement = player.query_place_ship
    until player_ship_placement.length == ship.length && @player_board.valid_placement?(ship, player_ship_placement)
      puts "Please select valid coordinates. Enter #{ship.length} coordinates separated by a space."
      player_ship_placement = player.query_place_ship
    end
    @player_board.place(ship, player_ship_placement)
    puts @player_board.render(true)
  end

  def end_game
    if @computer_cruiser.sunk? && @computer_submarine.sunk?
      print "You win!\n"
      true
    elsif @player_cruiser.sunk? && @player_submarine.sunk?
      print "I win!\n"
      true
    else
      false
    end
  end

  def turn
    Turn.new(player, computer, player_board, computer_board)
  end

  def run_game
    computer_place_ship(@computer_cruiser)
    computer_place_ship(@computer_submarine)
    create_player_board_intro
    player_place_ship(@player_cruiser)
    player_place_ship(@player_submarine)
    until end_game
      new_turn = turn()
      new_turn.run_turn(@computer_cruiser, @computer_submarine)
    end
    Game.new.main_menu
    # main_menu
  end


end
