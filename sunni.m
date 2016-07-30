function sunni()
%% statemachine

while (1)
    switch(situation)
        case 'INIT'
            success = initialization();
            if (success==1)
                situation = 'LOADING';
            end

                
        case 'LOADING'
            situation = loading();
            
            
            
    end
    
end


end