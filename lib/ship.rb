class Ship

  attr_reader :name,
              :length,
              :health
  def initialize(name, length)
    @name = name
    @length = length
    @health = []
  end

  def health
    @health
  end

  def hit
    if @health = length
      @health -= 1
    elsif @health < length && sunk? != true
      @health -= 1
    else sunk? == true
  end

  def sunk?
    false
  end

end
