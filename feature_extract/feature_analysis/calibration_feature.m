%% study the role of calibration in feature domain
% - calibration_frequency(cover_audio_file_original, stego_audio_file_original, cover_audio_file_calibration, stego_audio_file_calibration)
% - Variables:
% ------------------------------------------input
% cover_audio_file_original         path of original cover audio file
% stego_audio_file_original         path of original stego audio file
% cover_audio_file_calibration      path of calibrated cover audio file
% stego_audio_file_calibration      path of calibrated stego audio file
% -----------------------------------------output
% Null

function calibration_feature(cover_audio_file_original, stego_audio_file_original, cover_audio_file_calibration, stego_audio_file_calibration)
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
figure(1);
subplot(121);checkerboard_plot(feature_dif_original, side, 'original');colorbar();
subplot(122);checkerboard_plot(feature_dif_calibration, side, 'calibration');colorbar();

% display
threshold = 0.01;
fprintf('Significant points, original: %d\n', length(find(feature_dif_original > threshold)));
fprintf('Significant points, calibration: %d\n', length(find(feature_dif_calibration > threshold)));