## Robot simulator

Implementation of a coding challenge to simulate a robot on a table in ruby

### Improvements / TODOS

This is a list of things that I intend to do next until I feel I've spent enough time on this already

1. make console interface operate with arbitrary streams and pass stdin and stdout
2. consider wrapping everything in modules
3. more testing, e.g:
    - Calling exception paths and testing exceptions are raised
    - possibly more comprehensive testing of CompassPoints module i.e.
        - are north/south and east/west vectors orthogonal
        - does 4 repetitive left/right turns end up at the same position
        - does a left then a right turn and vice versa always end up at the same position
        - is the movement vector after 2 left/right turns always the opposite of the original
    - Test console interface with mock IO streams (need to do 1 to enable ddoing this)

This is a list of things that I think would make sense to do but weren't in the spec

- Have a method for the robot to report what table it is on.
- have the console reader indicate something has happened to the user on each command and re-prompt regardless of if a REPORT command was received
- give the user feedback on invalid commands rather than ignoring them.