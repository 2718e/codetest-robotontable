require "matrix"

# module providing mapping of compass directions to vectors, 
# and which compass directions are left and right of each other
module CompassPoints


  NAMES = {
    :north => "NORTH",
    :east => "EAST",
    :south => "SOUTH",
    :west => "WEST"
  }

  MOVE_VECTORS = {
    :north => Vector[0,1],
    :east => Vector[1,0],
    :south => Vector[0,-1],
    :west => Vector[-1,0]
  }

  LEFT_TURNS = {
    :north => :west,
    :west => :south,
    :south => :east,
    :east => :north
  }

  RIGHT_TURNS = LEFT_TURNS.invert

  NAMES.freeze
  MOVE_VECTORS.freeze
  LEFT_TURNS.freeze
  RIGHT_TURNS.freeze

end