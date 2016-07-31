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
phase = floor(duration/180); %one phase takes 120 seconds
if (pot/(2^phase) > 115) %pot size only with the blinds and antes
                         %somebody already committed chips to the pot
                         %when this is true
    RAB = 1;%1 for true
else
    RAB = 0;%0 for false
end

tupel_n = [N PB RAB];
tupel = tupel_n*10.^(numel(tupel_n)-1:-1:0).'; %transformation to num
disp(['tupel: ',num2str(tupel)]) 

switch tupel
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
    case 140
        disp('Folded in HeadsUp')%the frequency can be stored fo HU-stgy
        situation = 'XXX';
    case 130
        disp('Folded in HeadsUp')
        situation = 'XXX';
    case 120
        disp('Folded in HeadsUp')
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
    case 231 
        if (M==4) %depending on player missing
            situation = 'RRSB';
        elseif (M==1)
            situation = 'RRBB';
        else
            situation = 'XXX';
        end
    case 221
        situation = 'RRBB';
    case 141
        situation = 'RRH';%react raise (or call) HeadsUp
    case 131
        situation = 'RRH';
    case 121
        situation = 'RRH';
    otherwise
        msg = 'could not confirm situation';
        warning(msg);
        situation = 'XXX';
        
        
end
        
        






end