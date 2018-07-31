close all;

cover_audio_file_original = 'audio_file/cover.txt';
stego_audio_file_original = 'audio_file/stego.txt';
cover_audio_file_calibration = 'audio_file/c_cover.txt';
stego_audio_file_calibration = 'audio_file/c_stego.txt';

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
subplot(311);
imshow(dif_cover_stego_original(:,1:QMDCT_num));
xlabel('Sampling Dots');ylabel('Amplitute');
title('cover\_original - stego\_original');

subplot(312);
imshow(dif_cover_stego_calibration(:,1:QMDCT_num));
xlabel('Sampling Dots');ylabel('Amplitute');
title('cover\_calibration - stego\_calibration');

subplot(313);
imshow(dif(:,1:QMDCT_num));
xlabel('Sampling Dots');ylabel('Amplitute');
title('dif\_cover\_cover - dif\_stego\_stego');

fprintf('Percentage of original cover and original stego: %.2f%%\n', 100*percentage_dif_cover_stego_original);
fprintf('Percentage of calibrated cover and original stego: %.2f%%\n', 100*percentage_dif_cover_stego_calibration);
fprintf('Percentage of difference after calibration: %.2f%%\n', 100*percentage_dif);