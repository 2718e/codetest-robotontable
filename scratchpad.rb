# this file is so I can test out language features / libraries, is not part of the solutions
require "matrix"

class MockTable5By5 

  def has_coordinate(position)
    position.all? {|coordinate| coordinate >=0 && coordinate <= 5 }
  end

end

TABLE = MockTable5By5.new

puts( TABLE.has_coordinate(Vector[0,5]) )
puts( TABLE.has_coordinate(Vector[3,3]) )
puts( TABLE.has_coordinate(Vector[-1,4]) )
puts( TABLE.has_coordinate(Vector[6,5]) )
puts( TABLE.has_coordinate(Vector[2,-4]) )
puts( TABLE.has_coordinate(Vector[0,7]) )


