function info = hascards2_0player()
%% function that returns information about player has folded or played 
global CLASSIFIER_Hascards;


        I = screencapture(0, [255,360,25,30]);
        I = rgb_to_gray(I);
        info1 = not(predict(CLASSIFIER_Hascards,extractHOGFeatures(I,'CellSize', [4 4])));              
        

        I = screencapture(0, [255,550,25,30]);
        I = rgb_to_gray(I);
        info2 = not(predict(CLASSIFIER_Hascards,extractHOGFeatures(I,'CellSize', [4 4])));         
        

        I = screencapture(0, [515,550,25,30]);
        I = rgb_to_gray(I);
        info3 = not(predict(CLASSIFIER_Hascards,extractHOGFeatures(I,'CellSize', [4 4])));
        
        
        INFO = [info1 info2 info3];
        info = find(INFO == 1);
        
end