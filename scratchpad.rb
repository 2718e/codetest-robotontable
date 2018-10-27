# this file is so I can test out language features / libraries, is not part of the solutions
require "observer"

class ConsoleReader
  include Observable

  def initialize
    @input = ""
  end

  def RunInterface
    while @input.upcase != "EXIT()"
      puts "Enter something or type EXIT() to quit"
      @input = gets.chomp
      changed
      notify_observers(@input)
    end
  end

end

class MockInputObserver
  def update(next_input)
    puts "This was Entered: '#{next_input}', OMG!!! :O"
  end
end

reader = ConsoleReader.new
notifier = MockInputObserver.new

reader.add_observer(notifier)
reader.RunInterface