clc;
close all;

[I, fs]= audioread('AUDIO.wav');     %To read the Orchestral Music 

l= length(I);            %length of original audio signal
l2=2.^nextpow2(l);       % next two pwer length
fi=fft(I,l2);            %fft of audio signal
fi=fi(1:l2/2);           %fft normalized to half of length


cut_off1= 200/fs/2;          %cut off frequency for low pass filter
h1= fir1(32,cut_off1,'low'); %design low pass filter
fh1=fft(h1,l2);              %fft of low pass filter 
fh1=fh1(1:l2/2);             %fft normalized to half of length
 
 
cut_off2= 30000/fs/2;         %cut off frequency for high pass filter
h2= fir1(32,cut_off2,'high'); %Design high pass filter
fh2=fft(h2,l2);               %fft of High pass filter
fh2=fh2(1:l2/2);              %fft normalized to half of length

con1=fh1.*fi;                 %frequency domain low pass filtered signal
LOW= abs(ifft(con1,l2));      %time domain low pass filtered signal

con2=fh2.*fi;                 %frequency domain high pass filtered signal
HIGH= abs(ifft(con2,l2));     %time domain high pass filtered signal

dF = fs/l2;                     
f = 0:dF:fs/2-dF;  
subplot(2,2,1);
plot(I);
title('original signal in time domain');
subplot(2,2,2);
plot(f,abs(fi));
title('original signal in frequency domain');
subplot(2,2,3);
plot(f,abs(fh1));
title('frequency domain impulse respone for low pass');
subplot(2,2,4);
plot(f,abs(fh2));
title('frequency domain impulse respone for high pass');
figure;
subplot(2,2,1);
plot(f,abs(con1));
title('frequency domain low pass filtered signal');
subplot(2,2,2);
plot(f,abs(con2));
title('frequency domain high pass filtered signal');
subplot(2,2,3);
plot(LOW);
title('time domain low pass filtered signal');
subplot(2,2,4);
plot(HIGH);
title('time domain high pass filtered signal');

%sound(I,fs);            %Orchestral Music
sound(LOW,fs);           %Low frequency based Music
sound(HIGH,fs);          %HIGH frequency based Music