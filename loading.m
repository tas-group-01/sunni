function  situation = loading()
%% confirm situation

% situation_x = {N,PB,RAB}
% N:=Number of Players involved(N=1,2,3)
% PB:=Position of the Button(PB=1,2,3,4)
% RAB:=Raise or Acted before(RAB=0,1)

%define situation1: situation_1 = {3,2,false}
[N,M] = involved();
PB = findB();
pot = pot_size();
duration = toc;
phase = floor(duration/180); %one phase takes 180 seconds
if (pot/(2^phase) > 115) %pot size only with the blinds and antes
                         %somebody already committed chips to the pot
                         %when this is true
    RAB = 1;%1 for true
else
    RAB = 0;%0 for false
end

% sb limped in
if (pot/(2^phase) == 140)
    RAB = 2;
elseif (pot/(2^phase) == 190)
    % sb limped + and another player
    RAB = 3;
elseif (pot/(2^phase) == 165)
    % another player limped in out of sb
    RAB = 4;
elseif (pot/(2^phase) == 215 && hascards(findB()) && hascards(findB()-1))
    % another two players limped in out of sb
    RAB = 5;
elseif (pot/(2^phase) == 240 && hascards(findB()) && hascards(findB()-1))
    % everybody limped in
    RAB = 6;    
%elseif (pot/(2^phase) == 215) no need for classifying this
%    % another player minraised
%    RAB = 7;
end

tupel_n = [N PB RAB];
tupel = tupel_n*10.^(numel(tupel_n)-1:-1:0).'; %transformation to num
disp(['tupel: ',num2str(tupel)]) 

switch tupel
    case 231
        situation = 'RRBB';
        
    case 330
        disp('Everybody folded')
        pause(6)%in order not to show cards
        situation = 'XXX';
    case 320
        situation = 'UDG'; %'under the gun'
    %case [3 4 0] does rarely happen, however action not efforded any case
    case 340
        situation = 'FASB'; %First to Act from Small Blind
    case 310
        situation = 'FAB'; %First to Act from Button
    case 240
        situation = 'FASB';
    case 230
        situation = 'FASB';%everybody folded included in this case
    %case [2 2 0] does rarely happen, however action not efforded any case
    case 210
        situation = 'FAB';
        pause(3)
    case 140
        disp('Folded in HeadsUp')%the frequency can be stored fo HU-stgy
        pause(5)
        situation = 'XXX';
    case 130
        disp('Folded in HeadsUp')
        pause(5)
        situation = 'XXX';
    case 120
        disp('Folded in HeadsUp')
        pause(5)
        situation = 'XXX';
    case 110
        situation = 'FAH';%First to Act HeadsUp
    case 341
        situation = 'RRSB';%React on Raise from SB
    case 311
        situation = 'RRB';%React on Raise fom Button
    case 331
        situation = 'RRBB';%React on Raise from BB
    case 241
        situation = 'RRSB';%React on Raise from SB
   % case 231 
   %     if (M==4) %depending on player missing
   %         situation = 'RRSB';
   %     elseif (M==1)
   %         situation = 'RRBB';
   %     else
   %         situation = 'XXX';
   %     end
    case 221
        situation = 'RRBB';
    case 141
        situation = 'RRH';%react raise (or call) HeadsUp
    case 131
        situation = 'RRH';
    case 121
        situation = 'RRH';
    case (112 || 122 || 132 || 142 || 212 || 222 || 232 || 242 || 312 || 322 || 332 || 342)
        % sb limped in other don't care RAB = 2;
        situation = 'SBL';
    case (113 || 123 || 133 || 143 || 213 || 223 || 233 || 243 || 313 || 323 || 333 || 343)
        % sb and another player limped in RAB = 3;
        situation = 'SBL+';
    case (114 || 124 || 134 || 144 || 214 || 224 || 234 || 244 || 314 || 324 || 334 || 344)
        % one other player limped in
        situation = 'L+';        
    case (115 || 125 || 135 || 145 || 215 || 225 || 235 || 245 || 315 || 325 || 335 || 345)
        % two other player limped in RAB = 5;
        situation = 'L++';
    case (116 || 126 || 136 || 146 || 216 || 226 || 236 || 246 || 316 || 326 || 336 || 346)
        % everybody limped in
        situation = 'SBL++';

%    case 312
%        situation ='SBL'; %small blind limped
%    case 323
%        situation = 'SBL+'; %small blind limped and another player
%    case 325
%        situation = 'SBL++'; %small blind limped and two other player
%    case 
        
    otherwise
        msg = 'could not confirm situation';
        warning(msg);
        pause(0.5)
        situation = 'XXX';
        
        
end

% take into account pot comittment

stack = my_pot(); 
disp(['STACK: ',num2str(stack)]);

if (50*(2^phase) < stack/6 && RAB == 0 && not(strcmp(situation,'RRH') || (strcmp(situation,'SBL') || strcmp(situation,'SBL+') || strcmp(situation,'L+') || strcmp(situation,'L++') || strcmp(situation,'SBL++'))));
    % pot committed
    situation = 'PCM'; %pot committed
    disp('Pot comitted')
end
    


        
        






end