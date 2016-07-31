function [N,M] = involved()
%% count players 
global CLASSIFIER_Plays;

filter = [-2 -2 -2;-2 14 -2;-2 -2 -2];
I1 = imfilter(rgb_to_gray(screencapture(0, [210,295,30,45])),filter);
I2 = imfilter(rgb_to_gray(screencapture(0, [215,610,30,45])),filter);
I3 = imfilter(rgb_to_gray(flip(screencapture(0, [545,610,30,45]),2)),filter);
I = [I1 I2 I3];
M = find(I==0)+1;
N = not(predict(CLASSIFIER_Plays,extractHOGFeatures(I1,'CellSize',[4 4])))+not(predict(CLASSIFIER_Plays,extractHOGFeatures(I2,'CellSize',[4 4])))+not(predict(CLASSIFIER_Plays,extractHOGFeatures(I3,'CellSize',[4 4])));




end