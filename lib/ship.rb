require "pry"

class Ship

  attr_reader :name,
              :length,
              :health
  def initialize(name, length)
    @name = name
    @length = length
    @health = [*length.downto(0)]
    @sunk = false
  end

  def health
    @health[0]
  end

  def hit
    @health = @health.rotate!
    if @health == 0
    @sunk = true
    end
  end

  def sunk?
    @sunk
  end

end
