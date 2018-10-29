require_relative 'commanddispatcher'
require_relative 'robot'
require_relative 'simtable'
require_relative 'consoleinterface'

include RobotOnTable

robot = Robot.new
table = SimTable.new 5
dispatcher = CommandDispatcher.new robot
reporter = ConsoleReporter.new
dispatcher.add_observer reporter
input_reader = ConsoleCommandReader.new table
input_reader.add_observer dispatcher

input_reader.run

