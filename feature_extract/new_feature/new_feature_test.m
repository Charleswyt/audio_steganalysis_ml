%% new feature performance test
% - new_feature_test(QMDCT_cover_path, QMDCT_stego_path)
% - Variable:
% ------------------------------------------input
% QMDCT_cover_path      QMDCT cover file path
% QMDCT_stego_path      QMDCT stego file path
% -----------------------------------------output
% Null

function new_feature_test(QMDCT_cover_path, QMDCT_stego_path)

if ~exist('QMDCT_cover_path', 'var') || isempty(QMDCT_cover_path) 
    QMDCT_cover_path = 'E:\Myself\2.database\mtap\mp3\cover\128';
end

if ~exist('QMDCT_stego_path', 'var') || isempty(QMDCT_stego_path) 
    QMDCT_stego_path = 'E:\Myself\2.database\mtap\mp3\stego\EECS\EECS_W_2_B_128_ER_10';
end

% QMDCT coefficients extraction
[QMDCT_num, QMDCT_files_num] = deal(500, 1000);
QMDCT_cover = qmdct_extract_batch(QMDCT_cover_path, QMDCT_num, QMDCT_files_num);
QMDCT_stego = qmdct_extract_batch(QMDCT_stego_path, QMDCT_num, QMDCT_files_num);

% feature extraction
feature_cover = feature_new_batch(QMDCT_cover, 5, 1000);
feature_stego = feature_new_batch(QMDCT_stego, 5, 1000);

% training and test
times = 10;
for i = 1:times
    result(i) = training(feature_cover, feature_stego);                     %#ok<AGROW>
end

% display training results
acc = 0;
for i = 1:10 
    acc = acc + result(i).ACC;
end
fprintf('Average Accuracy: %.2f%%\n', 100 * acc / 10);