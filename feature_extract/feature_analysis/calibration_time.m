cover_audio_file_original = 'audio_file/cover.mp3';
stego_audio_file_original = 'audio_file/stego.mp3';
cover_audio_file_calibration = 'audio_file/c_cover.mp3';
stego_audio_file_calibration = 'audio_file/c_stego.mp3';

cover_audio_original = audioread(cover_audio_file_original);
stego_audio_original = audioread(stego_audio_file_original);
cover_audio_calibration = audioread(cover_audio_file_calibration);
stego_audio_calibration = audioread(stego_audio_file_calibration);

dif_original = cover_audio_original - stego_audio_original;
dif_calibration = cover_audio_calibration - stego_audio_calibration;
dif = dif_original - dif_calibration;

fs = 44100;
duration = round(50 * 10 / 384 * fs);

figure(1);
subplot(211);
plot(dif_original(1:duration,1));
xlabel('Sampling Dots');ylabel('Amplitute');

subplot(212);
plot(dif_calibration(1:duration,1));
xlabel('Sampling Dots');ylabel('Amplitute');

figure(2);
plot(dif(1:duration,1));