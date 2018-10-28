require_relative 'compasspoints'
require 'observer'
require 'matrix'

# lookup for symbols of basic commands
# place is not included here as this has arguments so is handled as a special case
COMMAND_LOOKUP = {
    'MOVE' => :move,
    'RIGHT' => :right,
    'LEFT' => :left,
    'REPORT' => :report
}.freeze

ORIENTATION_LOOKUP = CompassPoints::NAMES.invert.freeze

# from https://stackoverflow.com/a/24980633
# converts s to an integer, but returns nil rather than 0
# if s is not numeric
def int_or_nil(s)
  Integer(s || '')
rescue ArgumentError
  nil
end

# parses commands from console and notifies observers whenever
# a valid command is parsed
class ConsoleCommandReader
  include Observable

  # initialized with a simulated table
  #
  # @param table: the table to place the robot on when notifying observers of place commands
  def initialize(table)
    @table = table
  end


  # parses a no argument command
  #
  # @param text: the command text
  def parse_normal_command(text)
    COMMAND_LOOKUP.key?(text) ? [COMMAND_LOOKUP[text], nil] : nil
  end

  # parses the arguments portion of the place command
  #
  # @param args_text: the part of the place command containing x, y and orientation
  def parse_place_args(args_text)
    parts = args_text.split(',')
    result = nil
    if parts.length == 3
      x = int_or_nil(parts[0])
      y = int_or_nil(parts[1])
      orientation = ORIENTATION_LOOKUP.key?(parts[2]) ? ORIENTATION_LOOKUP[parts[2]] : nil
      unless x.nil? || y.nil? || orientation.nil?
        result = [:place, [Vector[x, y], orientation, @table]]
      end
    end
    result
  end

  # for correctly formatted commands, returns a symbol representing the command and
  # the arguments.
  # (for commands that do not require arguments, will return nil for the arguments)
  #
  # @param command_text: the line of console input - is assumed to have already been trimmed
  def parse_command(command_text)
    parts = command_text.split(' ')
    if parts.length == 1
      parse_normal_command(parts[0])
    elsif parts.length == 2 && parts[0] == 'PLACE'
      parse_place_args(parts[1])
    end
  end

  # reads commands from console in a loop
  # and notifies observers when a valid command is received
  def run
    puts 'type commands, EXIT() to quit'
    input = ''
    while input != 'EXIT()'
      input = gets.chomp
      command = parse_command(input)
      unless command.nil?
        changed
        notify_observers(command[0], command[1])
      end
    end
  end

end

# when reports are received from obserables that this observes,
# writes them to console
class ConsoleReporter

  def update(position, orientation)
    puts "#{position[0]},#{position[1]},#{CompassPoints::NAMES[orientation]}"
  end

end