function sunni()
%% statemachine

%declare all classifiers and load from workspace
global CLASSIFIER_Initialization;
global CLASSIFIER_Pot;
global CLASSIFIER_Plays;
global CLASSIFIER_Button;
global CLASSIFIER_Cards;
global CLASSIFIER_Hascards;
CLASSIFIER_Initialization=evalin('base','CLASSIFIER_Initialization');
CLASSIFIER_Pot=evalin('base', 'CLASSIFIER_Pot');
CLASSIFIER_Plays=evalin('base', 'CLASSIFIER_Plays');
CLASSIFIER_Button=evalin('base', 'CLASSIFIER_Button');
CLASSIFIER_Cards=evalin('base', 'CLASSIFIER_Cards');
CLASSIFIER_Hascards=evalin('base', 'CLASSIFIER_Hascards');
tic;

action = what_happenend()
return

situation = 'INIT';
while (1)
    switch(situation)
        case 'INIT'
            pause(6); %let blinds increase and take time 
            disp('INIT phase')
            success = initialization();
            if (success==1)
                situation = 'LOADING';
            end

                
        case 'LOADING'
            situation = loading();
            
        case 'UDG'
            action_udg();
            situation = 'INIT';
            
        case 'FASB'
            action_fasb();
            situation = 'INIT';
            
        case 'FAB'
            action_fab();
            situation = 'INIT';
            
        case 'FAH'
            action_fah();
            situation = 'INIT';
            
        case 'RRSB'
            action_rrsb();
            situation = 'INIT';
            
        case 'RRB'
            action_rrb();
            situation = 'INIT';
            
        case 'RRBB'
            action_rrbb();
            situation = 'INIT';
            
        case 'RRH'
            action_rrh();
            situation = 'INIT';
            
        otherwise
            situation = 'INIT';
            
            
    end
    
end


end