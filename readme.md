## Robot simulator

Implementation of a coding challenge to simulate a robot on a table in ruby

### Improvements / TODOS

This is a list of things that I intend to do next until I feel I've spent enough time on this already

- make console interface operate with arbitrary streams and pass stdin and stdout
- more testing, e.g:
    - Calling exception paths and testing exceptions are raised
    - possibly more comprehensive testing of CompassPoints module
    - Test console interface with mock IO streams

This is a list of things that I think would make sense to do but aren't in the spec

- have a method for the robot to report which table it is on.