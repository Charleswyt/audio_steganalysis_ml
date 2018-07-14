%% threshold T select (the input matrices are fixed)
% matrix: QMDCT,  DR1_QMDCT,  DR2_QMDCT,  DC1_QMDCT,  DC2_QMDCT
%     ABS_QMDCT, ADR1_QMDCT, ADR2_QMDCT, ADC1_QMDCT, ADC2_QMDCT
% Threshold T: 3,4,5,6,7,8,9,10,11,12,13,14,15
% SVM calssfier, 10 times mean
% condition: EECS, 128kbps, 100%RER, W=2, H=7

cover_files_path = 'E:\Myself\2.database\mtap\txt\cover\128';
% stego_files_path = 'E:\Myself\2.database\mtap\txt\stego\EECS\EECS_W_2_B_128_ER_05';
stego_files_path = 'E:\Myself\2.database\mtap\txt\stego\HCM\HCM_B_128_ER_05';

% cover_files_path = 'E:\Myself\2.database\mtap\txt\cover\mp3stego_128';
% stego_files_path = 'E:\Myself\2.database\mtap\txt\stego\HCM\HCM_B_128_ER_05';

QMDCT_num = 500;
file_num = 1000;
T = [3,4,5,6,7,8,9,10];
train_set_percent = 0.8;
times = 3;
acc = zeros(1, length(T));
k = 1;

cover_QMDCTs = qmdct_extract_batch(cover_files_path, QMDCT_num, file_num);
stego_QMDCTs = qmdct_extract_batch(stego_files_path, QMDCT_num, file_num);

for t = T
    feature_cover = wang_new_batch(cover_QMDCTs, t);
    feature_stego = wang_new_batch(stego_QMDCTs, t);
    
    accuracy = zeros(1, times);
    for i = 1:times
        result = training(feature_cover, feature_stego, train_set_percent);
        accuracy(i) = result.ACC;
    end
    acc(k) = mean(accuracy);
    k = k + 1;
    fprintf('===================================\n');
    fprintf('Threshold T=%d selection completes.\n', t);
end

k = 1;
for t = T
    fprintf('Final Accuracy: %.2f%%, T = %d\n', 100*acc(k), t);
    k = k + 1;
end