# Class representing the table on which the robot is to be placed
class SimTable

  # initializes the table
  #
  # @param size: how many squares on each dimension of the table
  def initialize(size)
    @size = size
  end

  # checks if the given coordinate is on the table
  #
  # @position the coordinate to check
  def has_coordinate(position)
    position.all? { |coordinate| coordinate >= 0 && coordinate < @size }
  end
end