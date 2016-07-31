function action_rrbb()
%% action reaction on raise within BB
global CLASSIFIER_Cards;

%read, filter and classify cards
filter = [-2 -2 -2;-2 14 -2;-2 -2 -2];
C1 = predict(CLASSIFIER_Cards,extractHOGFeatures(imfilter(rgb_to_gray(screencapture(0, [490,320,25,30])),filter), 'CellSize', [4 4]));
C2 = predict(CLASSIFIER_Cards,extractHOGFeatures(imfilter(rgb_to_gray(screencapture(0, [515,315,25,30])),filter), 'CellSize', [4 4]));
C = [C1 C2];

if ((C1==C2)&& C1 > 8)
    click_max();
elseif (max(C) == 14 && min(C) > 10)
    click_max();
else
    click_fold();
end





end