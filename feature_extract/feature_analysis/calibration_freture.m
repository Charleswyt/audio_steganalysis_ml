close all;

% file path
cover_audio_file_original = 'audio_file/cover.txt';
stego_audio_file_original = 'audio_file/stego.txt';
cover_audio_file_calibration = 'audio_file/c_cover.txt';
stego_audio_file_calibration = 'audio_file/c_stego.txt';

% load
cover_audio_original = load(cover_audio_file_original);                             % cover, original
stego_audio_original = load(stego_audio_file_original);                             % stego, original
cover_audio_calibration = load(cover_audio_file_calibration);                       % cover, calibration
stego_audio_calibration = load(stego_audio_file_calibration);                       % stego, calibration

% cut
QMDCT_num = 450;
cover_audio_original = cover_audio_original(:,1:QMDCT_num);
stego_audio_original = stego_audio_original(:,1:QMDCT_num);
cover_audio_calibration = cover_audio_calibration(:,1:QMDCT_num);
stego_audio_calibration = stego_audio_calibration(:,1:QMDCT_num);

% feature extraction
[T, order] = deal(5, 1);
direction = 'v';
side = 2 * T + 1;
feature_cover_original = get_markov(cover_audio_original, direction, T, order);
feature_stego_original = get_markov(stego_audio_original, direction, T, order);
feature_cover_calibration = get_markov(cover_audio_calibration, direction, T, order);
feature_stego_calibration = get_markov(stego_audio_calibration, direction, T, order);

% reshape
feature_cover_original = reshape(feature_cover_original, side, side);feature_cover_original = feature_cover_original';
feature_stego_original = reshape(feature_stego_original, side, side);feature_stego_original = feature_stego_original';
feature_cover_calibration = reshape(feature_cover_calibration, side, side);feature_cover_calibration = feature_cover_calibration';
feature_stego_calibration = reshape(feature_stego_calibration, side, side);feature_stego_calibration = feature_stego_calibration';

% get difference
feature_dif_original = feature_cover_original - feature_stego_original;
feature_dif_calibration = feature_cover_calibration - feature_stego_calibration;

% plot
figure(1);checkerboard_plot(feature_dif_original);
figure(2);checkerboard_plot(feature_dif_calibration);

% display
threshold = 0.01;
fprintf('Significant points, original: %d\n', length(find(feature_dif_original > threshold)));
fprintf('Significant points, calibration: %d\n', length(find(feature_dif_calibration > threshold)));