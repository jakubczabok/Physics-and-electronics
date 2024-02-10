% This MATLAB script generates output signal using Fourier transform

% parameters of R-C
% resistor R [Ω]
R = 1e3; 
% capacitor C [F]
C = 40e-6;

% parameters of input signal
% number of overtones
n = 10; 
% amplitude
A = input('enter amplitude: ');
% minimal frequency [Hz]
f_min = 1; 
% maximial frequency [Hz]
f_max = 100; 

% establishing number of samples and steps
% sampling frequency [Hz]
fs = 2*f_max; 
% sampling interval [s]
Ts = 1/fs;
% number of samples
M = input('enter number of samples (power of number 2): ');
% time vector
t = (0:M-1)*Ts; 

% generating output signal
x = zeros(1, M);
for i = 1:n
    % random frequency [Hz]
    fi = f_min + (f_max-f_min)*rand(); 
    % overtone
    xi = A*cos(2*pi*fi*t); 
    % sum of overtones
    x = x + xi; 
end

% calculating output signal
y = zeros(1, M);
for i = 2:M
    y(i) = y(i-1) + (x(i) - y(i-1))/(R*C*fs);
end

% displaying results
figure;
subplot(2,1,1);
plot(t, x, 'b', t, y, 'r');
xlabel('time [s]');
ylabel('amplitude');
legend('input signal', 'output signal');

subplot(2,2,3);
amplitude_spectrum(x, fs);
title('amplitude spectrum of input signal');
subplot(2,2,4);
amplitude_spectrum(y, fs);
title('amplitude spectrum of output signal');

figure;
subplot(2,2,1);
phase_spectrum(x, fs);
title('phase spectrum of input signal');
subplot(2,2,2);
phase_spectrum(y, fs);
title('phase spectrum of output signal');

% function to generate amplitude spectrum 
function amplitude_spectrum(x, fs)
    % length of signal
    N = length(x);
    % frequency vector
    f = (0:N-1)*(fs/N);
    % amplitude spectrum as absolute values ​​after performing 
    % a discrete Fourier transform of the signal normalized by the signal length
    X = abs(fft(x))/N;
    % creating chart
    plot(f, X);
    xlabel('frequency [Hz]');
    ylabel('amplitude');
end

% function to generate phase spectrum
function phase_spectrum(x, fs)
    % length of signal
    N = length(x);
    % frequency vector
    f = (0:N-1)*(fs/N);
    % discrete Fourier transform of the signal normalized by the signal length
    X = fft(x)/N;
    % scaling spectrum for frequencies
    X = X(1:N/2+1);
    % phase spectrum as phase angles of spectrum after removing jumps between -pi and pi
    phase = unwrap(angle(X));
    % creating chart
    plot(f(1:N/2+1), phase);
    xlabel('frequency [Hz]');
    ylabel('phase [rad]');
end
