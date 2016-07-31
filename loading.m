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
phase = floor(duration/120); %one phase takes 120 seconds
if (pot/(2^phase) > 115) %pot size only with the blinds and antes
                         %somebody already committed chips to the pot
                         %when this is true
    RAB = 1;%1 for true
else
    RAB = 0;%0 for false
end

tupel = [N PB RAB];

switch tupel
    case [3 2 0]
        situation = 'UDG'; %'under the gun'
    %case [3 4 0] does rarely happen, however action not efforded any case
    case [3 4 0]
        situation = 'FASB'; %First to Act from Small Blind
    case [3 1 0]
        situation = 'FAB'; %First to Act from Button
    case [2 4 0]
        situation = 'FASB';
    case [2 3 0]
        situation = 'FASB';%everybody folded included in this case
    %case [2 2 0] does rarely happen, however action not efforded any case
    case [2 1 0]
        situation = 'FAB';
    case [1 4 0]
        disp('Folded in HeadsUp')%the frequency can be stored fo HU-stgy
    case [1 3 0]
        disp('Folded in HeadsUp')
    case [1 2 0]
        disp('Folded in HeadsUp')
    case [1 1 0]
        situation = 'FAH';%First to Act HeadsUp
    case [3 4 1]
        situation = 'RRSB';%React on Raise from SB
    case [3 1 1]
        situation = 'RRB';%React on Raise fom Button
    case [3 3 1]
        situation = 'RRBB';%React on Raise from BB
    case [2 4 1]
        situation = 'RRSB';%React on Raise from SB
    case [2 3 1] 
        if (M==4) %depending on player missing
            situation = 'RRSB';
        elseif (M==1)
            situation = 'RRBB';
        end
    case [2 2 1]
        situation = 'RRBB';
    case [1 4 1]
        situation = 'RRH';%react raise (or call) HeadsUp
    case [1 3 1]
        situation = 'RRH';
    case [1 2 1]
        situation = 'RRH';
        
        
end
        
        






end