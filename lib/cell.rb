class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_status = false  ## should @fired_upon be cell status? If so, write an if
      ## statement for fired_upon? method
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_status
  end

  def fire_upon
    @fired_status = true
    if empty? == false
      @ship.hit
    end
  end

  def render(reveal = false)
    if reveal == true
      # if @ship.sunk?
      #   "X"
      if @ship != nil && @fired_status == false
        "S"
      # elsif @ship != nil && @fired_status == true
        # "H"
      end
    elsif reveal == false
      if @fired_status == false
        "."
      elsif @fired_status == true && @ship == nil
        "M"
      elsif @ship.sunk? == true
        "X"
      elsif @fired_status == true && @ship != nil
        "H"
      end
    end
  end
end
