require_relative '../robot'
require 'matrix'

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

def initialize_robot(position, orientation, table)
  robot = Robot.new
  robot.place(position, orientation, table)
  robot
end

def check_position_and_orientation(robot, expected_position, expected_orientation)
  expect(robot.get_position).to eq expected_position
  expect(robot.get_orientation).to eq expected_orientation
end

# convenience method to execute command series
def test_command_sequence(test_description, initial_position, initial_orientation, table, expected_final_position, expected_final_orientation)
  it test_description do
    robot = initialize_robot(initial_position, initial_orientation, table)
    yield robot
    check_position_and_orientation(robot, expected_final_position, expected_final_orientation)
  end
end

def test_move(test_description, initial_position, orientation, table, expected_final_position)
  test_command_sequence(test_description, initial_position, orientation, table, expected_final_position, orientation, &:move_forward)
end

describe Robot do
  context 'Checking place method' do
    it 'should be placed on the table if a valid position is given' do
      robot = initialize_robot(Vector[3, 3], :east, MOCK_TABLE_5BY5)
      check_position_and_orientation(robot, Vector[3, 3], :east)
    end

    it 'should ignore a place command that is off the table' do
      robot = initialize_robot(Vector[2, 5], :south, MOCK_TABLE_5BY5)
      check_position_and_orientation(robot, nil, nil)
    end

    it 'should execute multiple place commands if all are valid' do
      robot = initialize_robot(Vector[1, 1], :west, MOCK_TABLE_3BY3)
      check_position_and_orientation(robot, Vector[1, 1], :west)
      robot.place(Vector[3, 4], :north, MOCK_TABLE_5BY5)
      check_position_and_orientation(robot, Vector[3, 4], :north)
    end

    it 'should remain in the same place if an invalid place command is issued when it already placed' do
      robot = initialize_robot(Vector[1, 0], :west, MOCK_TABLE_3BY3)
      check_position_and_orientation(robot, Vector[1, 0], :west)
      robot.place(Vector[3, -1], :north, MOCK_TABLE_3BY3)
      check_position_and_orientation(robot, Vector[1, 0], :west)
    end
  end

  context 'Checking move_forward method' do
    test_move('should increment the y position when moving forward while facing north, leaving orientation unchanged',
              Vector[2, 2], :north, MOCK_TABLE_5BY5, Vector[2, 3])

    test_move('should decrement the y position when moving forward while facing south, leaving orientation unchanged',
              Vector[2, 2], :south, MOCK_TABLE_5BY5, Vector[2, 1])

    test_move('should increment the x position when moving forward while facing east, leaving orientation unchanged',
              Vector[2, 2], :east, MOCK_TABLE_5BY5, Vector[3, 2])

    test_move('should decrement the x position when moving forward while facing west, leaving orientation unchanged',
              Vector[2, 2], :west, MOCK_TABLE_5BY5, Vector[1, 2])
  end
end
