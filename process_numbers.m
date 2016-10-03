function number = process_numbers(img,index)
%% function that takes processed filtered and index where to start and finds number

%global CLASSIFIER_Pot;

% analyse in frequency domain
X = zeros(1,length(img));
for i = 4:length(img)-4
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
for i = index+5: -1:1 %to be on the safe side
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

%peak
% index should depend on how many digits I have
% find the $
% $ characteristica
% 5 col
col1 = [0;0;0;74;0;0;0;44;255];
col2 = [0;0;255;0;255;0;0;0;255];
col3 = [100;255;255;0;255;255;0;0;255];
col4 = [0;74;0;0;0;255;0;0;255];
col5 =  [0;138;136;0;0;0;255;255;0];
col = [col1 col2 col3 col4 col5];

correlation = 0;
for i = 5:length(img)-5
        for j = 1:6
        img_cols = [(img(j:end-(7-j),i-2)) (img(j:end-(7-j),i-1)) (img(j:end-(7-j),i)) (img(j:end-(7-j),i+1)) (img(j:end-(7-j), i+2))];
        
                % Ähnlichkeit/Correlation definieren und bestimmen
                res_corr = corr(col,double(img_cols));
                res_corr = diag(res_corr);
                %sum(res_corr(:))
                if isfinite(sum(res_corr(:))) && sum(res_corr(:)) > correlation
                        d_index = i;
                        correlation = sum(res_corr(:));
                end
        end
end


peak

d_index
% find the relevant peaks
index = find(peak > d_index);
peak = peak(index);

peak = peak(2:end);
peak(1:end) = peak(end:-1:1);
peak
%if ~four_digits
%	peak = peak(1:4);
%else
	% cut of the dot .
%	peak(end - 2 ) = -100;
%	idx = find(peak ~= -100);
%	peak = peak(idx);
%end
peak 

%cut off digits and transform into number
I_cell = cell(1,length(peak));
for i = 1:length(peak) 
	%width for every digit: 6 pixels
	if i == 3  % i = 3 ansonsten immer verschoben
		img_raw = img(2:end-1,peak(i) + 1:peak(i) + 1 + 6);
	else
		img_raw = img(2:end-1,peak(i):peak(i)+6);
	end
	idx = find(img_raw < 180); % filter out noise expecially at the edges 
	img_raw(idx) = 0;
	I_cell{i} = img_raw;
		
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
