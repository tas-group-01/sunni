function success = initialization()
%% initialization
global CLASSIFIER_Initialization;
features=extractHOGFeatures(screencapture(0, [385,155,125,55]), 'CellSize', [4 4]);

label = predict(CLASSIFIER_Initialization, features); 

while(label == 1)
    
    pause(1); 

    features=extractHOGFeatures(screencapture(0, [385,155,125,55]), 'CellSize', [4 4]);
    label = predict(CLASSIFIER_Initialization, features);
    % reclassification in cases of missclassification
    if (label == 0)
        pause(1);
        label = predict(CLASSIFIER_Initialization, features);
        % when everybody folded to BB avoid classification and thus wait
        pause(6);
    end
        
end
success = 1;
end