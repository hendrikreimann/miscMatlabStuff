function [f, P1] = myfft(x, Fs)

% Fs = fp.Frequency;
T = 1/Fs;

L = length(x);


t = (0:L-1)*T;   

f = Fs*(0:(L/2))/L;

% hack bc some trials have NaN as last sample
% x=fp.Force(:,1:L)' - nanmean(fp.Force');

Y =fft(x);

P2 = abs(Y/L);
P1 = P2(1:L/2+1,:);

plot(f,P1);