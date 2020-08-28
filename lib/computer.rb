class Computer
  # We need cell array. It can be hardcoded for now
  #   Hardcode "usable" cells in that array
  #   COME BACK TO THIS: Run that array against cell.valid_placement?
  def initialize(board)
    @cells = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    board = board.cells
  end

  def valid_placement?(starting_cell, ship_length, randomizer)
    starting_letter = starting_cell[0]
    starting_num = starting_cell[1]
    if randomizer == "left/right" && (starting_num - ship_length) < 0
      # nums must add
    elsif randomizer == "left/right" && (starting_num - ship_length) >= 0
      # nums must subtract
    elsif randomizer == "up/down" && (starting_letter.ord - 64 - ship_length) < 0
      # letters.ord must add
    elsif randomizer == "up/down" && (starting_letter.ord - 64 - ship_length) < 0
      #letters.ord must subtract
    end
  end

  ###ords: "A"=65, "B"=66, "C"=67, "D"=68

  def query_place_ship(ship_length)
    starting_cell = @cells.sample  # A1
    ship_placement = []
    # randomly choose up/down or left/right. There will be (ship.length - 1) cells that need to be placed on (e.g. cruiser is 3 long, so 2 will have to be left.)
    # starting_letter = starting_cell[0]
    # starting_num = starting_cell[1]
    randomizer = ["up/down", "left/right"].sample
    require "pry"; binding.pry
    valid_placement?(starting_cell, ship_length, randomizer)
    #8PM UPDATE - GOING FORWARD:
    # - randomizer runs to see if ship will go up/down or left/right
    # - the starting cell will be run through valid_placement? This will give us the info we need to know where the remaining cells go (whether up, down, left, or right)
    # - We'll then map those coordinates to the ship_placement array and return that to the game.

    # random1 = (starting_cell.split("")).sample
    # random2 = ["plus", "minus"].sample
    # if random1 == "A" &&

  end

end
