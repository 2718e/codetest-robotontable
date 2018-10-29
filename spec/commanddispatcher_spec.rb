require_relative '../robot'
require_relative '../compasspoints'
require_relative '../commanddispatcher'
require_relative '../simtable'
require 'matrix'
require 'observer'

include RobotOnTable

MOCK_TABLE_5BY5 = SimTable.new 5

class MockCommandSource
  include Observable

  def call_notify_observers(command, args = nil)
    changed
    notify_observers(command, args)
  end

end

class MockReportSink

  def initialize(dispatcher)
    dispatcher.add_observer(self)
    @last_position = nil
    @last_orientation = nil
  end

  def update(position, orientation)
    @last_orientation = orientation
    @last_position = position
  end

  attr_reader :last_position, :last_orientation

end

def test_command_performed(description, command, initial_postion, initial_orientation, _final_position, final_orientation)
  it description do
    r = Robot.new
    r.place(initial_postion, initial_orientation, MOCK_TABLE_5BY5)
    dispatcher = CommandDispatcher.new(r)
    dispatcher.process_command(command)
    expect(r.orientation).to eq final_orientation
  end
end

def test_turn_command_performed(description, command, initial_orientation, final_orientation)
  test_command_performed(description, command, Vector[2, 2], initial_orientation, Vector[2, 2], final_orientation)
end

def test_place_command()
  context "Checking the place command" do
    it "should place a robot when a place command is given" do
      r = Robot.new
      dispatcher = CommandDispatcher.new(r)
      dispatcher.process_command(:place, [Vector[1,1], :south, MOCK_TABLE_5BY5])
      expect(r.position).to eq Vector[1, 1]
      expect(r.orientation).to eq :south
    end
  end
end

def test_observer_behavior
  context "Checking response to observable commands" do
    it "should recieve commands from an observable source" do
      observable_source = MockCommandSource.new
      r = Robot.new
      dispatcher = CommandDispatcher.new(r)
      observable_source.add_observer(dispatcher)
      observable_source.call_notify_observers(:place, [Vector[0,3], :east, MOCK_TABLE_5BY5])
      observable_source.call_notify_observers(:move)
      expect(r.position).to eq Vector[1, 3]
      expect(r.orientation).to eq :east
    end
  end
end

def test_observable_behavior
  context "Checking report produces observable updates" do
    it "should notify observers when a report command is recieved" do
      r = Robot.new
      r.place(Vector[2,4], :west, MOCK_TABLE_5BY5)
      dispatcher = CommandDispatcher.new(r)
      sink = MockReportSink.new(dispatcher)
      dispatcher.process_command(:report)
      expect(sink.last_position).to eq Vector[2,4]
      expect(sink.last_orientation).to eq :west
    end
  end
end

describe CommandDispatcher do
  context 'Checking turn and move commands are passed to the robot' do
    test_turn_command_performed('Should turn left when a :left command is sent', :left, :north, :west)
    test_turn_command_performed('Should turn right when a :right command is sent', :right, :north, :east)
    test_command_performed("Should move forward when a :move command is send", :move, Vector[2,2], :east, Vector[3,2], :east)
  end
  test_place_command
  test_observer_behavior
  test_observable_behavior
end
