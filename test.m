[y_128, Fs_128] = audioread('E:\Myself\2.database\3.cover\cover_10s\128\wav10s_00001.mp3');
[y_192, Fs_192] = audioread('E:\Myself\2.database\3.cover\cover_10s\192\wav10s_00001.mp3');
[y_256, Fs_256] = audioread('E:\Myself\2.database\3.cover\cover_10s\256\wav10s_00001.mp3');
[y_320, Fs_320] = audioread('E:\Myself\2.database\3.cover\cover_10s\320\wav10s_00001.mp3');

figure(1);plot(y_128(:,1));
figure(2);plot(y_192(:,1));
figure(3);plot(y_256(:,1));
figure(4);plot(y_320(:,1));