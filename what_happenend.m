function action = what_happenend()
%% function that describes which player acted before

% defining struct for player1-3 and initialisation
field1 = 'player1'; %fold, call, raise (0, 1, 2)
field2 = 'player2';
field3 = 'player3';
action = struct(field1,0,field2,0,field3,0);

% game duration: blinds increase every 3 minutes
duration = toc;
phase = floor(duration/180);
% size of the current pot
pot = pot_size();
% current Button position
button = findB(); % my_seat:1 then clockwise ->2->3->4

    
    switch button
        case 4
            
            if pot/(2^phase) <= 115
                action.player1 = -1; % has still to act
                action.player2 = 0;
                action.player3 = 0;
                return;
 
            elseif pot/(2^phase) <= 165
                [~,in_idx] = involved();
                action.player1 = -1;
                if length(in_idx) > 2
                    msg = 'in_idx too long for button case 4';
                    warning(msg);
                elseif in_idx == 2
                    action.player2 = 1;
                    action.player3 = 0;
                    return;
                elseif in_idx == 3
                    action.player2 = 0;
                    action.player3 = 1;
                    return;
                end
                
            elseif pot/(2^phase) <=215
                [~,in_idx] = involved();
                action.player1 = -1;
                if length(in_idx) == 2
                    switch in_idx(2)
                        case 2
                            action.player2 = 2;
                            action.player3 = 0;
                            return;
                        case 3
                            action.player2 = 0;
                            action.player3 = 2;
                            return;
                        otherwise
                            msg = 'classification problem1.0';
                            warning(msg);
                            return;
                    end
                elseif length(in_idx) == 3
                    action.player1 = 1;
                    action.player2 = 1;
                    return;
                else
                     msg = 'classification problem2.0';
                     warning(msg);
                     return;
                end
            else
                [~,in_idx] = involved();
                action.player1 = -1;
                if length(in_idx) == 2
                    switch in_idx(2)
                        case 2
                            action.player2 = 2;
                            action.player3 = 0;
                            return;
                        case 3
                            action.player2 = 0;
                            action.player3 = 2;
                            return;
                        otherwise
                            msg = 'classification problem3.0';
                            warning(msg);
                            return;
                    end
                 elseif length(in_idx) == 3
                    action.player1 = 2;
                    action.player2 = 2;
                    return;
                else
                     msg = 'classification problem4.0';
                     warning(msg);
                     return;
                end   
            end
            
        case 2
            action.player1 = -1;
            action.player2 = -1;
            action.player3 = -1;
            return;
            
        case 1
            if pot/(2^phase) <= 115
                action.player1 = -1;
                action.player2 = -1;
                action.player3 = 0;
                return;
            elseif pot/(2^phase) <= 165
                action.player1 = -1;
                action.player2 = -1;
                action.player3 = 1;
                return;
            else
                action.player1 = -1;
                action.player2 = -1;
                action.player3 = 2;
                return;
            end
            
        case 3 %% this case has to be done properly because many options
            if pot/(2^phase) <= 140
                action.player1 = 0;
                action.player2 = 0;
                action.player3 = 1;
                return;
            elseif pot/(2^phase) <= 165
                [~,in_idx] = involved();
                switch in_idx(1)
                    case 1               
                        action.player1 = 1;
                        action.player2 = 0;
                        action.player3 = 0;
                    case 2
                        action.player1 = 0;
                        action.player2 = 1;
                        action.player3 = 0;
                end
            elseif pot/(2^phase) <= 190
                 [~,in_idx] = involved();
                switch in_idx(1)
                    case 1               
                        action.player1 = 1;
                        action.player2 = 0;
                        action.player3 = 1;
                    case 2
                        action.player1 = 0;
                        action.player2 = 1;
                        action.player3 = 1;
                end 
            else pot/(2^phase) <= 240
                [~,in_idx] = involved();
                if length(in_idx) == 3
                    action.player1 = 1;
                    action.player2 = 1;
                    action.player3 = 1;
                elseif length(in_idx) == 2
                    switch in_idx(1)
                        case 1
                            action.player1 = 2;
                            action.player2 = 0;
                            action.player3 = 0;
                
                

            
    end
    
          




end