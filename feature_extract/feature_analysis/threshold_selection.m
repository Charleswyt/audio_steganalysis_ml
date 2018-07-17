%% threshold T selection (the input matrices are fixed)
% matrix: QMDCT,  DR1_QMDCT,  DR2_QMDCT,  DC1_QMDCT,  DC2_QMDCT
%     ABS_QMDCT, ADR1_QMDCT, ADR2_QMDCT, ADC1_QMDCT, ADC2_QMDCT
% Threshold T: 3,4,5,6,7,8,9,10,11,12,13,14,15
% SVM calssfier, 10 times mean
% condition: EECS, 128kbps, 100%RER, W=2, H=7

bitrate = [128, 192, 256, 320];
stego_method = {'HCM', 'EECS'};

cover_dir = 'E:\Myself\2.database\mtap\txt\cover';
stego_dir = 'E:\Myself\2.database\mtap\txt\stego';

% cover_files_path = 'E:\Myself\2.database\mtap\txt\cover\mp3stego_128';
% stego_files_path = 'E:\Myself\2.database\mtap\txt\stego\HCM\HCM_B_128_ER_05';

QMDCT_num = 500;
file_num = 1000;
T = [3,4,5,6,7,8,9,10];
train_set_percent = 0.8;
times = 3;
acc = zeros(length(bitrate) * length(stego_method), length(T));

for b = 1:length(bitrate)
    cover_files_path = fullfile(cover_dir, num2str(bitrate(b)));
    cover_QMDCTs = qmdct_extract_batch(cover_files_path, QMDCT_num, file_num);
    
    for s = 1:length(stego_method)
        if strcmp(stego_method{s}, 'EECS')
            stego_files_name = [stego_method{s}, '_W_2_B_', num2str(bitrate(b)), '_ER_05'];
        else
            stego_files_name = [stego_method{s}, '_B_', num2str(bitrate(b)), '_ER_05'];
        end
        stego_files_path = fullfile(stego_dir, stego_method{s}, stego_files_name);
        stego_QMDCTs = qmdct_extract_batch(stego_files_path, QMDCT_num, file_num);
        
        k = 1;
        for t = T
            feature_cover = all_matrices_batch(cover_QMDCTs, t, file_num);
            feature_stego = all_matrices_batch(stego_QMDCTs, t, file_num);
            accuracy = zeros(1, times);
            for i = 1:times
                result = training(feature_cover, feature_stego, train_set_percent);
                accuracy(i) = result.ACC;
            end
            acc((b-1)*4+s, k) = mean(accuracy);
            k = k + 1;
            fprintf('===================================\n');
            fprintf('%s, Threshold T=%d selection completes.\n', stego_files_name, t);
        end
    end
end

for b = 1:length(bitrate)
    fprintf('============================\n');
    for s = 1:length(stego_method)
        k = 1;
        for t = T
            fprintf('Final Accuracy: %.2f%%, T = %d\n', 100*acc((b-1)*4+s, k), t);
            k = k + 1;
        end
    end
end