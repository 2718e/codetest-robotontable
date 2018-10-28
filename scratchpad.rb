# this file is so I can test out language features / libraries, is not part of the solutions
require "observer"

class ThingWithAccessors

  def initialize
    @moo = "moo"
  end

  def moo
    @moo
  end

end

puts (ThingWithAccessors.new.moo)