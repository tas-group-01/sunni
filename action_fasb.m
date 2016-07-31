function action_fasb()
%% action from small blind
global CLASSIFIER_Cards;

%read, filter and classify cards
filter = [-2 -2 -2;-2 14 -2;-2 -2 -2];
C1 = predict(CLASSIFIER_Cards,extractHOGFeatures(imfilter(rgb_to_gray(screencapture(0, [490,320,25,30])),filter), 'CellSize', [4 4]));
C2 = predict(CLASSIFIER_Cards,extractHOGFeatures(imfilter(rgb_to_gray(screencapture(0, [515,315,25,30])),filter), 'CellSize', [4 4]));
C = [C1 C2];

if (C1==C2)
    click_max();
elseif (min(C) < 4 && max(C) < 12 && abs(min(C)-max(C)) > 2)
    click_fold();
elseif (max(C) < 5)
    click_fold();
else
    click_max()
end


end