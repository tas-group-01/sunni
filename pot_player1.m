function [pot] = pot_player1(g_scale)
%% function that classifies the chips committed to the pot by player1
disp('pot_player1() invoked!')

global CLASSIFIER_Pot;

filter = [-2 -2 -2;-2 14 -2;-2 -2 -2];

I = screencapture(0, [300,375,100,15]);
I = rgb_to_gray(I);
I = imfilter(I,filter);
% von hinten die Zahlen analysieren und durchgehen bis zum $ und Punkt überspringen
imshow(I) 

%v_min = 8000;
%idx1 = 0;
%idx2 = 0;
% iterate over the whole captured image
% not mandatory to iterate until end

% defining X in order to find local minima of X; 
% the n - 1 local inimum should be the starting point i.e. idx1
X = zeros(1,100);
I_ = zeros(15,99);
I_(:,:) = I(:,1:99);
I_ = horzcat(I_,I(:,end-1),I(:,end-1),I(:,end-1));
%I_(:,1:100) = I(:,1:100);
%I_(:,101:102) = I(:,end-2:end-1);

for i = 1:length(I)  
	v1 = sum(I_(:,i));
	v2 = sum(I_(:,i+1));
	v3 = sum(I_(:,i+2));
	v = [v1 v2 v3];
	v = sum(v);
	X(i) = v;
%	if v < v_min
%		v_min = v;
%		idx1 = i+2; % start from there where the numbers start
%	end

%	Xinv = 1.01*max(X) - X;
%	[Minima,MinIdx] = findpeaks(Xinv);
end

%        Xinv = 1.01*max(X) - X;
%        [Minima,MinIdx] = findpeaks(Xinv);



%figure(2);
%plot(X)

Fs = 1000; % Sampling frequency
T = 1/Fs; % Sampling period
L = 100;  % Length of the signal
t = (0:L-1)*T; % Time vector


figure(2);
plot(1000*t(1:90),X(1:90))
title('Original signal of the captured and filtered image')
xlabel('samples')
ylabel('gauss filtered sum of samples')

% compute Fourier transform of the signal
Y = fft(X);
% view MATLAB help 'two sided spectrum'
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs * (0:(L/2))/L;
figure(3);
plot(f,P1)
title('Single-Sided Amplitude Spectrum of gauss filtered v(x)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

figure(4);
test = ifft((Y));
plot(test)

% define signal parameters and gaussian pulse in time domain
Fs = 1000; % Sampling frequency
T = 1/Fs;
L = 100;
%g_scale = 1000;
t = (-L/2:L/2-1)*T*g_scale;

%t = -0.05:1/Fs:0.05; % Time vector
%L = length(t);     % Signal length

% this can be tuned
sigma = 0.01; 
X_gausspulse = 1/(4*sqrt(2*pi*sigma))*(exp(-t.^2/(2*sigma)));
figure(5);
title('Gaussian Pulse in Time Domain')
xlabel('Time (t)')
ylabel('X(t)')

% convert signal to frequency domain
n = 2^nextpow2(L);
%Y_gausspulse = fft(X_gausspulse,n);
Y_gausspulse = fft(X_gausspulse);

% define the frequency domain and plot the unique frequencies
f = Fs*(0:(n/2))/n;
P = abs(Y_gausspulse/n);

plot(f,P(1:n/2+1))
title('Gaussian pulse in frequency domain')
xlabel('Frequency (f)')
ylabel('|P(f)|')

figure(6);
X_filtered = fftshift(ifft(Y.*Y_gausspulse));
plot(X_filtered)

%X_filtered_inv = 1.01*max(X_filtered) - X_filtered;
%[Minima, MinIdx] = findpeaks(X_filtered_inv);

% find deepest descend
desc = 0;
for i = 10:length(X_filtered)-10
	descent = X_filtered(i-8) - X_filtered(i + 8);
	if descent > desc
		desc = descent;
		index = i;
	end
end
index

I_cell = process_numbers(I,index);

pot = I_cell;

end
