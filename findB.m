function Button = findB()
%% finds position of the button
global CLASSIFIER_Button;
%global game_duration;

% introducing filter for robustness
filter = [-2 -2 -2;-2 14 -2;-2 -2 -2];

%prediction
B1 = predict(CLASSIFIER_Button, extractHOGFeatures(imfilter(rgb_to_gray(screencapture(0, [310,340,25,25])),filter),'CellSize', [4 4]));
B2 = predict(CLASSIFIER_Button, extractHOGFeatures(imfilter(rgb_to_gray(screencapture(0, [220,570,25,25])),filter),'CellSize', [4 4]));
B3 = predict(CLASSIFIER_Button, extractHOGFeatures(imfilter(rgb_to_gray(screencapture(0, [475,575,25,25])),filter),'CellSize', [4 4]));
B0 = predict(CLASSIFIER_Button, extractHOGFeatures(imfilter(rgb_to_gray(screencapture(0, [565,350,25,25])),filter),'CellSize', [4 4]));

B = [B0 B1 B2 B3];
if sum((B)) > 1
    msg = 'button classification failed 1.0';
    warning(msg);
end
Button = find(B ~= 0);
if length(Button) > 1
    msg = 'button classification failed 1.1';
    warning(msg);
end

%for circling
if Button == 0
    Button = 4;
elseif Button == 5;
    Button = 1;
end

end