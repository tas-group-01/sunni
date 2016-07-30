function success = initialization ()
%% initialization
features=extractHOGFeatures(screencapture(0, [385,155,125,55]), 'CellSize', [4 4]);

label = predict(CLASSIFIER_Initialization, features); 

while(label == 1)

    features=extractHOGFeatures(screencapture(0, [385,155,125,55]), 'CellSize', [4 4]);
    label = predict(CLASSIFIER_Initialization, features);
    % reclassification in cases of missclassification
    if (label == 0)
        pause(1);
        label = predict(CLASSIFIER_Initialization, features);
    end
        
end
success = 1;
end