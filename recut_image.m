function [I_ret] = recut_image(I) 
%% function that recuts image properly
disp('recut_image() invoked!')
g_scale = 40;
filter = [-2 -2 -2;-2 14 -2;-2 -2 -2];

I = screencapture(0, [420,528,100,15]);
I = rgb_to_gray(I);
I = imfilter(I,filter);

X = zeros(1,100);
I_ = zeros(15,99);
I_(:,:) = I(:,1:99);
I_ = horzcat(I_,I(:,end-1),I(:,end-1),I(:,end-1));

for i = 1:length(I)  
	v1 = sum(I_(:,i));
	v2 = sum(I_(:,i+1));
	v3 = sum(I_(:,i+2));
	v = [v1 v2 v3];
	v = sum(v);
	X(i) = v;
end

Fs = 1000; % Sampling frequency
T = 1/Fs; % Sampling period
L = 100;  % Length of the signal
t = (0:L-1)*T; % Time vector


%figure(2);
%plot(1000*t(1:90),X(1:90))
%title('Original signal of the captured and filtered image')
%xlabel('samples')
%ylabel('gauss filtered sum of samples')

% compute Fourier transform of the signal
Y = fft(X);
% view MATLAB help 'two sided spectrum'
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs * (0:(L/2))/L;
%figure(3);
%plot(f,P1)
%title('Single-Sided Amplitude Spectrum of gauss filtered v(x)')
%xlabel('f (Hz)')
%ylabel('|P1(f)|')

%figure(4);
%test = ifft((Y));
%plot(test)

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
%figure(5);
%title('Gaussian Pulse in Time Domain')
%xlabel('Time (t)')
%ylabel('X(t)')

% convert signal to frequency domain
n = 2^nextpow2(L);
%Y_gausspulse = fft(X_gausspulse,n);
Y_gausspulse = fft(X_gausspulse);

% define the frequency domain and plot the unique frequencies
f = Fs*(0:(n/2))/n;
P = abs(Y_gausspulse/n);

%plot(f,P(1:n/2+1))
%title('Gaussian pulse in frequency domain')
%xlabel('Frequency (f)')
%ylabel('|P(f)|')

figure(6);
X_filtered = fftshift(ifft(Y.*Y_gausspulse));
plot(X_filtered)
title('Guass filtered signal')

X_filtered_inv = 1.01*max(X_filtered) - X_filtered;
[Minima, MinIdx] = findpeaks(X_filtered_inv);

MinIdx
Minima
Minima(1) = 0;
Minima(end-1:end) = 0;
idx = find(Minima == max(Minima));

col1 = [0;0;0;74;0;0;0;44;255];
col2 = [0;0;255;0;255;0;0;0;255];
col3 = [100;255;255;0;255;255;0;0;255];
col4 = [0;74;0;0;0;255;0;0;255];
col5 =  [0;138;136;0;0;0;255;255;0];
col = [col1 col2 col3 col4 col5];

correlation = 0;
for i = 5:length(I)-5
	for j = 1:6
        img_cols = [(I(j:end-(7-j),i-2)) (I(j:end-(7-j),i-1)) (I(j:end-(7-j),i)) (I(j:end-(7-j),i+1)) (I(j:end-(7-j), i+2))];
	
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
d_index
%%%%%% added to process image for 3 and 4
%[idx] = find(MinIdx > d_index);

end_point = MinIdx(idx)-2;%to be on the safe side

for i = end_point:length(I)
	I(:,i) =  [255;0;0;0;0;0;0;0;0;0;0;0;0;0;255];
end
I(:,end) = [255;255;255;255;255;255;255;255;255;255;255;255;255;255;255];

%%%%%% added to process image for 3 and 4

I_ret = I;
end
