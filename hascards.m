function info = hascards(p)
%% function that returns information about player has folded or played 
global CLASSIFIER_Hascards;

switch p
    case 2
        I = screencapture(0, [255,360,25,30]);
        I = rgb_to_gray(I);
        info = not(predict(CLASSIFIER_Hascards,extractHOGFeatures(I,'CellSize', [4 4])));              
        
    case 3
        I = screencapture(0, [255,550,25,30]);
        I = rgb_to_gray(I);
        info = not(predict(CLASSIFIER_Hascards,extractHOGFeatures(I,'CellSize', [4 4])));         
        
    case 4
        I = screencapture(0, [515,550,25,30]);
        I = rgb_to_gray(I);
        info = not(predict(CLASSIFIER_Hascards,extractHOGFeatures(I,'CellSize', [4 4])));   
        
    case 1
        % bot itself always has cards
        info = 1;
        
    otherwise
        msg = 'not suited input';
        warning(msg);
        info = 1000;
        
end


end