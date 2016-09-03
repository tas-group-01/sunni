function pot = my_pot()
%% function that returns stack size
% algorithmus for classification of the Pot
filter = [-2 -2 -2;-2 14 -2;-2 -2 -2];
I_ = screencapture(0, [590,302,45,10]);
I = imfilter(I_,filter);
global CLASSIFIER_Pot;

pot = 0;
ref = 1000;
pot_4_digits = 8;

for i=1:14 %find the $
    if (sum(I(:,i))==2550 && ref == 1000)
        ref = i; %$
        if ref < 6
            %pot value > 1000
            pot_4_digits = 1;
        elseif ref < 12
            %pot value < 1000
            pot_4_digits = 0;
        elseif ref < 15
            %pot value < 100
            pot_4_digits = -1;
            
        end
        
    end            
end

switch pot_4_digits
    case 0
       %classify the first, second, ... value for pot value < 1000
       first = I(:,ref+5:ref+11);
       second = I(:,ref+13:ref+19);
       third = I(:,ref+21:ref+27); 
       %perform classification
       digit_1 = predict(CLASSIFIER_Pot, extractHOGFeatures(first, 'CellSize', [2 2])); 
       digit_2 = predict(CLASSIFIER_Pot, extractHOGFeatures(second, 'CellSize', [2 2])); 
       digit_3 = predict(CLASSIFIER_Pot, extractHOGFeatures(third, 'CellSize', [2 2]));
       %transform to number
       n = [digit_1 digit_2 digit_3];
       pot = n*10.^(numel(n)-1:-1:0).';
    case 1
        %classify the first, second, ... value for pot value > 1000
        first = I(:,ref+5:ref+11);
        second = I(:,ref+16:ref+22);
        third = I(:,ref+24:ref+30);
        fourth = I(:,ref+32:ref+38);
        %perform classification
        digit_1 = predict(CLASSIFIER_Pot, extractHOGFeatures(first, 'CellSize', [2 2])); 
        digit_2 = predict(CLASSIFIER_Pot, extractHOGFeatures(second, 'CellSize', [2 2])); 
        digit_3 = predict(CLASSIFIER_Pot, extractHOGFeatures(third, 'CellSize', [2 2])); 
        digit_4 = predict(CLASSIFIER_Pot, extractHOGFeatures(fourth, 'CellSize', [2 2]));
        %transform to number
        n = [digit_1 digit_2 digit_3 digit_4];
        pot = n*10.^(numel(n)-1:-1:0).';
    case -1
        %classify the first, second for pot value < 100
        first = I(:,ref+5:ref+11);
        second = I(:,ref+16:ref+22);        
        %perform classification
        digit_1 = predict(CLASSIFIER_Pot, extractHOGFeatures(first, 'CellSize', [2 2])); 
        digit_2 = predict(CLASSIFIER_Pot, extractHOGFeatures(second, 'CellSize', [2 2])); 
        %transform to number
        n = [digit_1 digit_2];
        pot = n*10.^(numel(n)-1:-1:0).';        
        
    case 8
        msg = 'error occured in classifying the pot';
        warning(msg);
end
 
    
    figure(1),
    hold on;
    imshow(I_)



end