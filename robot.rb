require_relative('compasspoints')

class Robot
  def initialize
    @position = nil
    @orientation = nil
    @table = nil
  end

  # Places the robot on the table
  #
  # @param position: a Vector representing the x and y coordinates
  # @param orientation: one of the symbols :north, :east, :south, :west
  # @param table: the table to place the robot on.
  #
  # table is expected to expose a has_coordinate method which returns a boolean that is true if the robot could move to the square 
  # without falling off.
  #
  # Does nothing if table.has_coordinate(position) returns false (can't place a robot on a coordinate that isn't on the table)
  def place(position, orientation, table)
    if table.has_coordinate(position)
      @position = position
      @orientation = orientation
      @table = table
    end
  end

  # Changes the orientation of the robot to 90 degrees left of it's current orientation
  def turn_left()
    unless @table.nil? || @orientation.nil? #theoretically @orientation should always be non nil once the robot is placed on the table, but checking anyway
      @orientation = CompassPoints::LEFT_TURNS[@orientation]
    end
  end

  # Changes the orientation of the robot to 90 degrees right of it's current orientation
  def turn_right()
    unless @table.nil? || @orientation.nil?
      @orientation = CompassPoints::RIGHT_TURNS[@orientation]
    end
  end

  # moves the robot forward one unit in the direction of @orientation.
  #
  # does nothing if this would result in moving the robot off the table
  def move_forward()
    unless @table.nil? || @position.nil? || @orientation.nil?  
      nextPosition = @position+CompassPoints::MOVE_VECTORS[@orientation]
      if @table.has_coordinate(nextPosition)
        @position = nextPosition
      end
    end
  end

  # accessor - returns the coordinates of the robot
  def get_position()
    @position
  end

  # accessor - returns the orientation of the robot
  def get_orientation()
    @orientation
  end
  
end
