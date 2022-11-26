clearvars;
clc
close all;

[x,Fs] = audioread('Input_audio.wav');
N = size(x,1);
f = Fs*(0:N-1)*N;
T = 1/Fs;
L = N;
t = (0:L-1)*T;
A = 0.04;

xnew = transpose(x); % xnew=x';
xn = xnew + A*randn(1,length(x));

audiowrite('Noisy-Signal.wav',xn,Fs);

load('Num.mat')

filtered_signal_2 = filter(Num,1,xn);

audiowrite('Output.wav',filtered_signal_2,Fs);

Order = filtord(Num);

%Graphs

[audio_in,audio_freq_sampl]=audioread('Input_audio.wav');
Length_audio=length(audio_in);
df=audio_freq_sampl/Length_audio;
frequency_audio=-audio_freq_sampl/2:df:audio_freq_sampl/2-df;
pow = (abs(x).^2)/Length_audio^2;

figure
subplot(3,1,1)
plot((frequency_audio),pow*4);
xlabel('Frequency');
ylabel('Power Spectral');
title('Power spectrum of Input signal');

[audio_in,audio_freq_sampl]=audioread('Noisy-Signal.wav');
Length_audio=length(audio_in);
df=audio_freq_sampl/Length_audio;
frequency_audio=-audio_freq_sampl/2:df:audio_freq_sampl/2-df;
pow = (abs(xn).^2)/Length_audio^2;

subplot(3,1,2)
plot((frequency_audio),pow*4);
xlabel('Frequency');
ylabel('Power Spectral');
title('Power spectrum of Noisy signal');

[audio_in,audio_freq_sampl]=audioread('Output.wav');
Length_audio=length(audio_in);
df=audio_freq_sampl/Length_audio;
frequency_audio=-audio_freq_sampl/2:df:audio_freq_sampl/2-df;
pow = (abs(filtered_signal_2).^2)/Length_audio^2;

subplot(3,1,3)
plot((frequency_audio),pow*4);
xlabel('Frequency');
ylabel('Power Spectral');
title('Power spectrum of Output signal');

[audio_in,audio_freq_sampl]=audioread('Input_audio.wav');
Length_audio=length(audio_in);
df=audio_freq_sampl/Length_audio;
frequency_audio=-audio_freq_sampl/2:df:audio_freq_sampl/2-df;

figure
subplot(3,1,1)
FFT_audio_in=fftshift(fft(audio_in))/length(fft(audio_in));

plot(frequency_audio,abs(FFT_audio_in));
title('FFT of Input Audio');
xlabel('Frequency(Hz)');
ylabel('Amplitude');

[audio_in,audio_freq_sampl]=audioread('Noisy-Signal.wav');
Length_audio=length(audio_in);
df=audio_freq_sampl/Length_audio;
frequency_audio=-audio_freq_sampl/2:df:audio_freq_sampl/2-df;

subplot(3,1,2)

FFT_audio_in=fftshift(fft(audio_in))/length(fft(audio_in));
plot(frequency_audio,abs(FFT_audio_in));
title('FFT of Noisy signal');
xlabel('Frequency(Hz)');
ylabel('Amplitude');

[audio_in,audio_freq_sampl]=audioread('Output.wav');
Length_audio=length(audio_in);
df=audio_freq_sampl/Length_audio;
frequency_audio=-audio_freq_sampl/2:df:audio_freq_sampl/2-df;

subplot(3,1,3)

FFT_audio_in=fftshift(fft(audio_in))/length(fft(audio_in));
plot(frequency_audio,abs(FFT_audio_in));
title('FFT of Output Audio');
xlabel('Frequency(Hz)');
ylabel('Amplitude');

figure
subplot(3,1,1)
plot(t , xnew);
title('Original: Time-domain');
xlabel('time(seconds)');
ylabel('Amplitude');
subplot(3,1,2)
plot(t , xn , 'r');
title('Noisy: Time-domain'); 
xlabel('time(seconds)'); 
ylabel('Amplitude');
subplot(3,1,3)
plot(t , filtered_signal_2 , 'g');
title('After processing Noisy: Time-domain');
xlabel('time(seconds)');
ylabel('Amplitude');

figure 
title('Pole zero Plot')
zplane(Num,1)
figure
title('Frequency Response')
freqz(Num,1,N)

%%
sound(x,Fs)
pause
%%
sound(xn,Fs)
pause
%%
sound(filtered_signal_2,Fs)




