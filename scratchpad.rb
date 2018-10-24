# this file is so I can test out language features / libraries, is not part of the solutions
require "matrix"

module Directions
  COMPASS_POINTS = {
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

end

puts (Directions::RIGHT_TURNS[:north])