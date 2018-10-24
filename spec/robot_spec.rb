require './robot'

describe Robot do
  context "Asking the robot if it is a robot" do
    it "should say 'I AM A ROBOT' when we call the ask_if_robot method" do
      robot = Robot.new
      expect(robot.ask_if_robot).to eq "I AM A ROBOT"
    end
  end
end
 
