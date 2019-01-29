class Ship

  attr_reader :name,
              :length,
              :health

  def initialize(name, length)
    @name = name
    @length = length
    @health = @length
  end

  def hit
    if @health < length && sunk? == false
      @health -= 1
    elsif @health = length
      @health -= 1
    else
      sunk?
    end
  end

  def sunk?
    if @health >= 1
      false
    elsif @health == 0
      true
    end
  end
end
