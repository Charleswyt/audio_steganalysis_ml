%% input matrix select
% matrix: QMDCT,  DR1_QMDCT,  DR2_QMDCT,  DC1_QMDCT,  DC2_QMDCT
%     ABS_QMDCT, ADR1_QMDCT, ADR2_QMDCT, ADC1_QMDCT, ADC2_QMDCT

cover_files_path = 'E:\Myself\2.database\mtap\txt\cover\128';
stego_files_path = 'E:\Myself\2.database\mtap\txt\stego\EECS\EECS_W_2_B_128_ER_10';

QMDCT_num = 500;
file_num = 1000;
T = 6;
train_set_percent = 0.8;

% cover_QMDCTs = qmdct_extract_batch(cover_files_path, QMDCT_num, file_num);
% stego_QMDCTs = qmdct_extract_batch(stego_files_path, QMDCT_num, file_num);
% 
feature_cover = wang_new_batch(cover_QMDCTs, T);
feature_stego = wang_new_batch(stego_QMDCTs, T);

times = 1;
accuracy = zeros(1, times);
for i = 1:times
    result = training(feature_cover, feature_stego, train_set_percent);
    accuracy(i) = result.ACC;
end
acc = mean(accuracy);
fprintf('Final Accuracy: %.2f\n', 100*acc);