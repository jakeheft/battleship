class Cell
  attr_reader :coordinate, :ship, :fired_status

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
      if !empty? && !fired_upon?
        "S"
      elsif !empty? && fired_upon?
        "H"
      elsif empty? && fired_upon?
        "M"
      elsif empty? && !fired_upon?
        "."
      elsif @ship.sunk?
        "X"
      end
    elsif reveal == false
      if @fired_status == false
        "."
      elsif @fired_status == true && @ship == nil
        "M"
      elsif @fired_status == true && @ship != nil
        "H"
      elsif @ship.sunk?
        "X"
      end
    end
  end
end
