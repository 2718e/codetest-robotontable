class SimTable
  def initialize(size)
    @size = size
  end

  def has_coordinate(position)
    position.all? { |coordinate| coordinate >= 0 && coordinate < @size }
  end
end