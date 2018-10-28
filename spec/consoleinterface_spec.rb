require_relative '../consoleinterface'
require_relative '../simtable'
require 'matrix'

table = SimTable.new 5
reader = ConsoleCommandReader.new table

describe ConsoleCommandReader do
  context 'checking command parsing method' do
    context 'checking parsing of commands with no arguments' do
      it 'should return nil when invalid command types are passed' do
        expect(reader.parse_command('KILLALLTHEHUMANS')).to eq nil
        expect(reader.parse_command('LOVE')).to eq nil
      end
      it 'should return the corresponding symbols, along with nil for the argument when valid commands with no arguments are passed' do
        [['MOVE', :move], ['LEFT', :left], ['RIGHT', :right], ['REPORT', :report]].each {|pair|
          expect(reader.parse_command(pair[0])).to eq [pair[1], nil]
        }
      end
    end
    context 'checking parsing of the place command' do
      it 'should return nil when given non integer arguments for x and y' do
        ['PLACE A,1,NORTH', 'PLACE 2,B,NORTH', 'PLACE 3.14,2.71,SOUTH'].each {|text|
          expect(reader.parse_command(text)).to eq nil
        }
      end
      it 'should return nil when given non compass directions for orientation' do
        ['PLACE 1,1,UP', 'PLACE 2,2,DOWN', 'PLACE 3,3,TIME'].each {|text|
          expect(reader.parse_command(text)).to eq nil
        }
      end
      it 'should return nil when given too few arguments' do
        expect(reader.parse_command('PLACE 1,2')).to eq nil
      end
      it 'should return nil when given too many arguments' do
        expect(reader.parse_command('PLACE 1,2,EAST,SOUTH')).to eq nil
      end
      it 'should return a structure with the symbol :place and arguments for the robot.place method when a valid command is given' do
        parsed = reader.parse_command('PLACE 1,2,EAST')
        expect(parsed[0]).to eq :place
        args = parsed[1]
        expect(args[0]).to eq Vector[1,2]
        expect(args[1]).to eq :east
        expect(args[2]).to eq table
      end
      it 'should parse and return place commands that would put the robot off the table (it is the responsibility of the robot to ignore them)' do
        parsed = reader.parse_command('PLACE 100,200,EAST')
        expect(parsed[0]).to eq :place
        args = parsed[1]
        expect(args[0]).to eq Vector[100,200]
        expect(args[1]).to eq :east
        expect(args[2]).to eq table
      end
    end
  end
end
