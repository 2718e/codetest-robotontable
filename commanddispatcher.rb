require "observer"

# handles commands from a command source
#
# dispatches most commands to the robot.
# 
# when a :report command is recieved, instead notifies observers of the reported position and orientaion
class CommandDispatcher
  include Observable

  def initialize(robot)
    @robot = robot
  end

  # recieves updates from observables - basically just calls process_command
  def update(command, args = nil)
    process_command(command, args)
  end

  # executes command depending on what type we received
  #
  # @param command: symbol denoting what command was received - either :place, :forward, :left, :right, :report
  # @param args: should be nil unless the command is :place - in which cases should be a list of the arguments to
  # place method of Robot (position, orientation, table)
  def process_command(command, args = nil)
    case command
    when :place
      if args.length != 3
        raise "Invalid number of arguments to :place command"
      end
      @robot.place(args[0],args[1],args[2])
    when :move
      @robot.move_forward
    when :left
      @robot.turn_left
    when :right
      @robot.turn_right
    when :report
      if @robot.placed?
        changed
        notify_observers(@robot.get_position, @robot.get_orientation)
      end
    else
      raise "Invalid Command"
    end

  end

end
