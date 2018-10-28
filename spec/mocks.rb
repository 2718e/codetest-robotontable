# file contiaining mock classes for the unit tests

class MockTable
  def initialize(size)
    @size = size
  end

  def has_coordinate(position)
    position.all? { |coordinate| coordinate >= 0 && coordinate < @size }
  end
end

MOCK_TABLE_5BY5 = MockTable.new 5
MOCK_TABLE_3BY3 = MockTable.new 3