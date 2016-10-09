function action = what_happenend()
%% function that describes which player acted before

% defining struct for player1-3 and initialisation
field1 = 'player1'; %still to act, fold, call, minraise, maxraise (-1,0, 1, 2, 3)
field2 = 'player2';
field3 = 'player3';

% game duration: blinds increase every 3 minutes 
duration = toc;
phase = floor(duration/180);
phase = 1;
% size of the current pot
pot = pot_size();
disp(['current pot size: ', num2str(pot)])
% current Button position
button = findB(); % my_seat:1 then clockwise ->2->3->4
disp(['Button position: ', num2str(button)])
% which player involved in the round
info = hascards2_0player();
disp(['Player involved: ', num2str(info)])
    
   % for now only valid for four players involved
	% modification with ability to read committed chips to the pot
    switch button
        case 4
            
            %%%if pot/(2^phase) <= 115
            %%%    action.player1 = -1; % has still to act
            %%%    action.player2 = 0;
            %%%    action.player3 = 0;
            %%%    return;
		%% remaining chips for each player should also be inserted %%
		action.player1 = 0;
		action.player2 = 0;
		action.player3 = 0;
		for i = 1:length(info)

			eval(['pot_pl = pot_player',num2str(info(i)),'(40);']);
			
			if pot_pl > 100*(2^phase)
				eval(['action.player',num2str(info(i)),'=3;']);
			elseif pot_pl > 50*(2^phase)
				eval(['action.player',num2str(info(i)),'=2;']);
			else
				eval(['action.player',num2str(info(i)),'=1;']);
			end
		action.player1 = -1; %always, because referring to the case
		end

        
        case 2
            %%%if pot/(2^phase) <= 115
            %%%    action.player1 = 0; % everybody folded
            %%%    action.player2 = 0; % this case will never appear
            %%%    action.player3 = 0; % in the algorthm but somehow
            %%%    return;             % has to be recognized for the
                                    % agression factor
   
		action.player1 = 0;
		action.player2 = 0;
		action.player3 = 0;
		for i = 1:length(info)

			eval(['pot_pl = pot_player',num2str(info(i)),'(40);']);

			if pot_pl > 100*(2^phase)
				 eval(['action.player',num2str(info(i)),'=3;']);
	                elseif pot_pl > 50*(2^phase)
                                eval(['action.player',num2str(info(i)),'=2;']);
                        else
                                eval(['action.player',num2str(info(i)),'=1;']);
                        end
		end

		if 1

          elseif pot/(2^phase) <= 140
                action.player1 = 0;
                action.player2 = 0;
                action.player3 = 1;
                return;
                
            elseif pot/(2^phase) <= 165
                info = hascards2_0player();
                switch info(1)
                    case 1
                        action.player1 = 1;
                        action.player2 = 0;
                        action.player3 = 0;
                        return;
                    case 2
                        action.player1 = 0;
                        action.player2 = 1;
                        action.player3 = 0;
                        return;
                end
                
            elseif pot/(2^phase) <= 190 % however be careful antes don't raise linearly
                info = hascards2_0player();
                switch info(1)
                    case 1
                        action.player1 = 1;
                        action.player2 = 0;
                        action.player3 = 1;
                        return;
                    case 2
                        action.player1 = 0;
                        action.player2 = 1;
                        action.player3 = 1;
                        return;
                end 
                
            elseif pot/(2^phase) <= 215
                info = hascards2_0player();
                if length(info) == 2
                    action.player1 = 1;
                    action.player2 = 1;
                    action.player3 = 0;
                    return;
                elseif info == 1
                    action.player1 = 2;
                    action.player2 = 0;
                    action.player3 = 0;
                    return;
                elseif info == 2
                    action.player1 = 0;
                    action.player2 = 2;
                    action.player3 = 0;
                    return;
                else
                    msg = 'missclassification 2.8';
                    warning(msg);
                    return;
                end
                
            else % find out who else involved with raise
                info = hascards2_0player();
                if length(info) == 3
                    action.player1 = 2;
                    action.player2 = 2;
                    action.player3 = 2;
                    return;
                elseif length(info) == 2
                    switch info(1)
                        case 1
                            action.player1 = 2;
                            switch info(2)
                                case 2
                                    action.player2 = 2;
                                    action.player3 = 0;
                                    return;
                                case 3
                                    action.player2 = 0;
                                    action.player3 = 2;
                                    return;
                            end
                        case 2
                            action.player1 = 0;
                            action.player2 = 2;
                            action.player3 = 2;
                            return;
                    end
                end
            end
            
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
                info = hascards2_0player();
                switch info(1)
                    case 1               
                        action.player1 = 1;
                        action.player2 = 0;
                        action.player3 = 0;
                        return;
                    case 2
                        action.player1 = 0;
                        action.player2 = 1;
                        action.player3 = 0;
                        return;
                end
            elseif pot/(2^phase) <= 190
                 info = hascards2_0player();
                switch info(1)
                    case 1               
                        action.player1 = 1;
                        action.player2 = 0;
                        action.player3 = 1;
                        return;
                    case 2
                        action.player1 = 0;
                        action.player2 = 1;
                        action.player3 = 1;
                        return;
                end 
                
            elseif pot/(2^phase) <= 190 % i.e. small blind raised
                action.player1 = 0;
                action.player2 = 0;
                action.player3 = 2; 
                return;

            elseif pot/(2^phase) <= 215 % i.e. small blind not involved
                info = hascards2_0player();
                if length(info) == 2
                    action.player1 = 1;
                    action.player2 = 1;
                    action.player3 = 0;
                    return;
                elseif length(info) == 1
                    switch info(1)
                        case 1
                            action.player1 = 2;
                            action.player2 = 0;
                            action.player3 = 0;
                            return;
                        case 2
                            action.player1 = 0;
                            action.player2 = 2;
                            action.player3 = 0;
                            return;
                    end
                end
                                         
            elseif pot/(2^phase) <= 240 % i.e. small blind limped in
               info = hascards2_0player();
               if length(info) == 3
                   action.player1 = 1;
                   action.player2 = 1;
                   action.player3 = 1;
                   return;
               end  
               
            else
                % see who raised and is involved
                info = hascards2_0player();
                if length(info) == 3
                    action.player1 = 2;
                    action.player2 = 2;
                    action.player3 = 2;
                elseif length(info) == 2
                    switch info(2)
                        case 3
                            action.player3 = 2;
                            switch (info(1))
                                case 1
                                    action.player1 = 2;
                                    action.player2 = 0;
                                case 2
                                    action.player1 = 0;
                                    action.player2 = 2;
                            end
                        case 2
                            action.player3 = 0;
                            action.player2 = 2;
                            action.player1 = 2;
                        case 1
                            msg = 'env misclassification 3.0';
                            warning(msg);
                    end
                end
            end
                            

                    

                
                

            
    end
    
          




end
