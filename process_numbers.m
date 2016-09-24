function number = process_numbers(img,index)
%% function that takes processed filtered and index where to start and finds number

global CLASSIFIER_Pot;

% analyse in frequency domain
X = zeros(1,length(img));
for i = 8:length(img)-8
	% low pass filtering
%	X(i) = 1/8*sum(img(:,i-3)) + 1/4* sum(img(:,i-2)) + 1/2*sum(img(:,i-1)) + sum(img(:,i)) + 1/2*sum(img(:,i+1)) + 1/4*sum(img(:,i+2)) + 1/8*sum(img(:,i+3)) ;
	X(i) = sum(img(:,i));
end
%finde die vordefinierten peaks
X_inv = 1.01*max(X) - X;
[Minima, MinIdx] = findpeaks(X_inv);
%until here the peaks are found robustly

z = 1;
four_digits = 0;
for i = index: -1:1 
%	if X(i) == 255*2
	if X(i) < 600 && ~isempty(find(i==MinIdx)) % if its not empty then index is contained as peak
		peak(z) = i;
		if z > 2
			if abs(peak(z-2)-peak(z-1)) < 5
				%number will not be greater than 4 digits in this game
				four_digits = 1;
				break;
			end
		end
		z = z + 1;
	end
end
peak
if ~four_digits
	peak = peak(1:4);
else
	% cut of the dot .
	peak(end - 2 ) = -100;
	idx = find(peak ~= -100);
	peak = peak(idx);
end
peak 

%cut off digits and transform into number
I_cell = cell(1,length(peak)-1);
for i = 0:length(peak) - 2 
	%width for every digit: 6 pixels 
	I_cell{i+1} = img(:,5+peak(end-i):-1:peak(end-i));
		
end

number = I_cell;
I_cell

% use peak in order to cut out the corresponding number
% take always the next 6 parts


% filter out the intersting frequencies i.e. high frequencies

figure(8);
plot(X)

%number = 1;


%stop = 1;
%for i = index: -1 : stop % if end value is reached stop classifiying (stop = 100)
	




end
