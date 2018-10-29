require_relative '../simtable'
require 'matrix'

include RobotOnTable

describe SimTable do
  context "checking has_coordinate method" do
    size = 5
    table = SimTable.new size
    context "checking points that should be on the table are" do
      ins = [Vector[0, 0], Vector[4, 0], Vector[0, 4], Vector[4, 4], Vector[1, 3], Vector[2, 2], Vector[3, 4], Vector[0, 3]]
      ins.each {|vec|
        it "should return true when has_coordinate called with #{vec} on a table of size #{size}" do
          expect(table.has_coordinate vec).to eq true
        end
      }
    end
    context "checking points that shouldn't be on the table aren't" do
      outs = [Vector[3, -1], Vector[-1, 3], Vector[5, 5], Vector[3, 5], Vector[5, 3], Vector[-1, 2], Vector[1, -1], Vector[-999, 3]]
      outs.each {|vec|
        it "should return false when has_coordinate called with #{vec} on a table of size #{size}" do
          expect(table.has_coordinate vec).to eq false
        end
      }
    end
  end
end