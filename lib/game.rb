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
      "You win!\n"
    elsif @player_cruiser.sunk? && @player_submarine.sunk?
      "I win!\n"
    end
  end

  def turn
    Turn.new(player, computer, player_board, computer_board)
  end

  def run_game
    # computer_place_ships
    computer_place_ship(@computer_cruiser)
    computer_place_ship(@computer_submarine)
    player_place_ships
    until game_over?
      new_turn = turn()
      new_turn.run_turn(@computer_cruiser, @computer_submarine)
    end
    puts end_game
    puts
    main_menu
  end


end
