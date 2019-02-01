class Ship

  attr_reader :name,
              :length,
              :health


  def initialize(name, length)
    @name = name
    @length = length
    @health = [*length.downto(0)]
  end

  def health
    @health.first
  end

  def hit
    if @health.first > 0
      @health = @health.rotate!
    end
  end

  def sunk?
   @health.first == 0
  end

end
