%% study the role of calibration in frequency domain
% - calibration_frequency(cover_audio_file_original, stego_audio_file_original, cover_audio_file_calibration, stego_audio_file_calibration)
% - Variables:
% ------------------------------------------input
% cover_audio_file_original         path of original cover audio file
% stego_audio_file_original         path of original stego audio file
% cover_audio_file_calibration      path of calibrated cover audio file
% stego_audio_file_calibration      path of calibrated stego audio file
% -----------------------------------------output
% Null

function calibration_frequency(cover_audio_file_original, stego_audio_file_original, cover_audio_file_calibration, stego_audio_file_calibration)
close all;

% file path
if ~exist('cover_audio_file_original', 'var') || isempty(cover_audio_file_original)
    cover_audio_file_original = 'audio_file/cover.txt';
end

if ~exist('stego_audio_file_original', 'var') || isempty(stego_audio_file_original)
    stego_audio_file_original = 'audio_file/stego.txt';
end

if ~exist('cover_audio_file_calibration', 'var') || isempty(cover_audio_file_calibration)
    cover_audio_file_calibration = 'audio_file/c_cover.txt';
end

if ~exist('stego_audio_file_calibration', 'var') || isempty(stego_audio_file_calibration)
    stego_audio_file_calibration = 'audio_file/c_stego.txt';
end

QMDCT_num = 450;

cover_audio_original = load(cover_audio_file_original);                             % cover, original
stego_audio_original = load(stego_audio_file_original);                             % stego, original
cover_audio_calibration = load(cover_audio_file_calibration);                       % cover, calibration
stego_audio_calibration = load(stego_audio_file_calibration);                       % stego, calibration

dif_cover_stego_original = cover_audio_original - stego_audio_original;             % differnece between original cover and original stego
dif_cover_stego_calibration = cover_audio_calibration - stego_audio_calibration;    % differnece between calibrated cover and calibrated stego

dif_cover_cover = cover_audio_original - cover_audio_calibration;                   % difference between original cover and calibrated cover
dif_stego_stego = stego_audio_original - stego_audio_calibration;                   % difference between original stego and calibrated stego
dif = dif_cover_cover - dif_stego_stego;                                            % difference between mentioned above

% calculate the percentage of different points
percentage_dif_cover_stego_original = length(find(dif_cover_stego_original ~= 0)) / 200 / QMDCT_num;
percentage_dif_cover_stego_calibration = length(find(dif_cover_stego_calibration ~= 0)) / 200 / QMDCT_num;
percentage_dif = length(find(dif ~= 0)) / 200 / QMDCT_num;

% plot
figure(1);
imshow(dif_cover_stego_original(:,1:QMDCT_num));
xlabel('Sampling Dots');ylabel('Amplitute');
title('cover\_original - stego\_original');

figure(2);
imshow(dif_cover_stego_calibration(:,1:QMDCT_num));
xlabel('Sampling Dots');ylabel('Amplitute');
title('cover\_calibration - stego\_calibration');

figure(3);
imshow(dif(:,1:QMDCT_num));
xlabel('Sampling Dots');ylabel('Amplitute');
title('dif\_cover\_cover - dif\_stego\_stego');

% display
fprintf('Percentage of original cover and original stego: %.2f%%\n', 100*percentage_dif_cover_stego_original);
fprintf('Percentage of calibrated cover and original stego: %.2f%%\n', 100*percentage_dif_cover_stego_calibration);
fprintf('Percentage of difference after calibration: %.2f%%\n', 100*percentage_dif);