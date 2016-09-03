function ScreenDimension = click(x,y)
%% in dieser Funktion wird ein Mausklick an den Pixelkoordinaten (x,y) generiert

import java.awt.Robot;
import java.awt.event.*;
robot = Robot();
ScreenDimension = get(0, 'screensize');

robot.mouseMove(x,y);
robot.mousePress(InputEvent.BUTTON1_MASK);
robot.mouseRelease(InputEvent.BUTTON1_MASK);

end