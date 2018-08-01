%% study the role of calibration in time domain
% - calibration_time(cover_audio_file_original, stego_audio_file_original, cover_audio_file_calibration, stego_audio_file_calibration)
% - Variables:
% ------------------------------------------input
% cover_audio_file_original         path of original cover audio file
% stego_audio_file_original         path of original stego audio file
% cover_audio_file_calibration      path of calibrated cover audio file
% stego_audio_file_calibration      path of calibrated stego audio file
% -----------------------------------------output
% Null

function calibration_time(cover_audio_file_original, stego_audio_file_original, cover_audio_file_calibration, stego_audio_file_calibration)

% file path
if ~exist('cover_audio_file_original', 'var') || isempty(cover_audio_file_original)
    cover_audio_file_original = 'audio_file/cover.mp3';
end

if ~exist('stego_audio_file_original', 'var') || isempty(stego_audio_file_original)
    stego_audio_file_original = 'audio_file/stego.mp3';
end

if ~exist('cover_audio_file_calibration', 'var') || isempty(cover_audio_file_calibration)
    cover_audio_file_calibration = 'audio_file/c_cover.mp3';
end

if ~exist('stego_audio_file_calibration', 'var') || isempty(stego_audio_file_calibration)
    stego_audio_file_calibration = 'audio_file/c_stego.mp3';
end

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
title('Difference between cover');

subplot(212);
plot(dif_calibration(1:duration,1));
xlabel('Sampling Dots');ylabel('Amplitute');
title('Difference between stego');

figure(2);
plot(dif(1:duration,1));