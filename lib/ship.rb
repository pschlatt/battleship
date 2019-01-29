require "pry"

class Ship

  attr_reader :name,
              :length,
              :health,
              :sunk
  def initialize(name, length)
    @name = name
    @length = length
    @health = [*length.downto(0)]
    @sunk = false
  end

  def health
    @health.first
  end

  def hit
      if @health.first > 0
        @health = @health.rotate!
      end
      
        @sunk = true

  end

  def sunk?
    @sunk
  end

end
