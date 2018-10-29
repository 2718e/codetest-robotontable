require 'matrix'

module RobotOnTable
  # module providing mapping of compass directions to vectors,
  # and which compass directions are left and right of each other
  module CompassPoints
    # String representation of the names
    NAMES = {
      north: 'NORTH',
      east: 'EAST',
      south: 'SOUTH',
      west: 'WEST'
    }.freeze

    # Mapping of the cardinal directions to x,y movement vectors
    MOVE_VECTORS = {
      north: Vector[0, 1],
      east: Vector[1, 0],
      south: Vector[0, -1],
      west: Vector[-1, 0]
    }.freeze

    # LEFT_TURNS[key] gives the direction that is 90 degrees to the left of the direction given by key
    LEFT_TURNS = {
      north: :west,
      west: :south,
      south: :east,
      east: :north
    }.freeze

    # LEFT_TURNS[key] gives the direction that is 90 degrees to the right of the direction given by key
    RIGHT_TURNS = LEFT_TURNS.invert.freeze
    end
end
