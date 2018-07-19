close all;

[audio_cover_128, fs] = audioread('E:\Myself\2.database\mtap\mp3\cover\128\wav10s_00001.mp3');
audio_stego_128 = audioread('E:\Myself\2.database\mtap\mp3\stego\EECS\EECS_W_2_B_128_ER_10\wav10s_00001_stego_128.mp3');
dif_128 = audio_cover_128 - audio_stego_128;

audio_cover_192 = audioread('E:\Myself\2.database\mtap\mp3\cover\192\wav10s_00001.mp3');
audio_stego_192 = audioread('E:\Myself\2.database\4.stego\EECS\192_W_2_H_7_ER_10\wav10s_00001.mp3');
dif_192 = audio_cover_192 - audio_stego_192;

audio_cover_256 = audioread('E:\Myself\2.database\mtap\mp3\cover\256\wav10s_00001.mp3');
audio_stego_256 = audioread('E:\Myself\2.database\4.stego\EECS\256_W_2_H_7_ER_10\wav10s_00001.mp3');
dif_256 = audio_cover_256 - audio_stego_256;

audio_cover_320 = audioread('E:\Myself\2.database\mtap\mp3\cover\320\wav10s_00001.mp3');
audio_stego_320 = audioread('E:\Myself\2.database\4.stego\EECS\320_W_2_H_7_ER_10\wav10s_00001.mp3');
dif_320 = audio_cover_320 - audio_stego_320;

duration = round(50 * 10 / 384 * fs);

figure(1);plot(audio_cover_128(1:duration,1));hold on;plot(dif_128(1:duration,1));
title('Bitrate = 128kbps');xlabel('Sampling Dots');ylabel('Amplitude');
figure(2);plot(audio_cover_192(1:duration,1));hold on;plot(dif_192(1:duration,1));
title('Bitrate = 192kbps');xlabel('Sampling Dots');ylabel('Amplitude');
figure(3);plot(audio_cover_256(1:duration,1));hold on;plot(dif_256(1:duration,1));
title('Bitrate = 256kbps');xlabel('Sampling Dots');ylabel('Amplitude');
figure(4);plot(audio_cover_320(1:duration,1));hold on;plot(dif_320(1:duration,1));
title('Bitrate = 320kbps');xlabel('Sampling Dots');ylabel('Amplitude');