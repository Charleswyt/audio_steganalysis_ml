%% plot the figure of time domain and frequency domain

close all;

cover_audio = audioread('E:\Myself\2.database\3.cover\cover_10s\128\wav10s_00004.mp3');
stego_audio = audioread('E:\Myself\2.database\4.stego\EECS\128_W_4_H_7_ER_10\train\wav10s_00004.mp3');
dif_audio = cover_audio - stego_audio;

cover_QMDCT = load('E:\Myself\2.database\10.QMDCT\1.txt\cover\128\wav10s_00004.txt');
stego_QMDCT = load('E:\Myself\2.database\10.QMDCT\1.txt\EECS\128_W_4_H_7_ER_10\wav10s_00004.txt');
dif_QMDCT = cover_QMDCT - stego_QMDCT;
dif = dif_QMDCT(:,1:380);

dif(dif ~= 0) = 255;

figure(1);
subplot(211);
plot(cover_audio(:,1));hold on;plot(dif_audio(:,1));
ylabel('Amplitude');
title('Left Channel');
subplot(212);
plot(cover_audio(:,2));hold on;plot(dif_audio(:,2));
xlabel('Sampling dots');ylabel('Amplitude');title('Right Channel');

figure(2);
imshow(dif);
xlabel('Frequency lines', 'FontSize', 13);ylabel('Channels', 'FontSize', 13);
title('QMDCT Coefficients Matrix', 'FontSize', 13);