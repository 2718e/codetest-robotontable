require_relative('compasspoints')

module RobotOnTable
  # Class representing a robot that we are simulating
  class Robot
    # initializes the robot, setting @position, @orientation and @table to nil
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
    def turn_left
      @orientation = CompassPoints::LEFT_TURNS[@orientation] if placed?
    end

    # Changes the orientation of the robot to 90 degrees right of it's current orientation
    def turn_right
      @orientation = CompassPoints::RIGHT_TURNS[@orientation] if placed?
    end

    # moves the robot forward one unit in the direction of @orientation.
    #
    # does nothing if this would result in moving the robot off the table
    def move_forward
      if placed?
        nextPosition = @position + CompassPoints::MOVE_VECTORS[@orientation]
        @position = nextPosition if @table.has_coordinate(nextPosition)
      end
    end

    # returns true if the robot has been placed on a table
    def placed?
      !(@table.nil? || @position.nil? || @orientation.nil?)
    end

    attr_reader :position, :orientation
  end
end
