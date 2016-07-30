function Button = findB()
%% finds position of the button
global CLASSIFIER_Button;

%prediction
B1 = predict(CLASSIFIER_Button, extractHOGFeatures(rgb_to_gray(screencapture(0, [310,340,25,25])),'CellSize', [4 4]));
B2 = predict(CLASSIFIER_Button, extractHOGFeatures(rgb_to_gray(screencapture(0, [220,570,25,25])),'CellSize', [4 4]));
B3 = predict(CLASSIFIER_Button, extractHOGFeatures(rgb_to_gray(screencapture(0, [475,575,25,25])),'CellSize', [4 4]));
B0 = predict(CLASSIFIER_Button, extractHOGFeatures(rgb_to_gray(screencapture(0, [565,350,25,25])),'CellSize', [4 4]));

B = [B0 B1 B2 B3];
if sum(not(B)) > 1
    msg = 'classification failed';
    warning(msg);
end

Button = find(B == 0);

end