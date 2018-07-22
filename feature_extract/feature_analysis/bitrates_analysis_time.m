% bitrate analysis in time domain

close all;

fs = 44100;
bitrate = [128, 192, 256, 320];
duration = round(50 * 10 / 384 * fs);
audio_file_name = 'wav10s_00001.mp3';
cover_audio_dir = 'E:\Myself\2.database\mtap\mp3\cover';
stego_audio_dir = 'E:\Myself\2.database\mtap\mp3\stego\EECS';

for b = 1:length(bitrate)
    cover_audio_path = fullfile(cover_audio_dir, num2str(bitrate(b)), audio_file_name);
    stego_audio_path = fullfile(stego_audio_dir, ['EECS_B_', num2str(bitrate(b)), '_W_2_H_7_ER_10'], audio_file_name);
    audio_cover = audioread(cover_audio_path);
    audio_stego = audioread(stego_audio_path);
    audio_dif = audio_cover - audio_stego;
    figure(b);
    plot(audio_cover(1:duration,1));hold on;plot(audio_dif(1:duration,1));
    title(['Bitrate = ', num2str(bitrate(b)), ' kbps']);xlabel('Sampling Dots');ylabel('Amplitude');
    fprintf('bitrate: %d, min: %.2f, max: %.2f\n', bitrate(b), min(audio_dif(:,1)), max(audio_dif(:,1)));
end