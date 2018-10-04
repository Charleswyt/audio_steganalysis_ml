%% text file path
QMDCT_files_path_cover = 'E:\Myself\2.database\10.QMDCT\cover\cover_10s\320\test';
QMDCT_files_path_stego = 'E:\Myself\2.database\10.QMDCT\stego\HCM\HCM_B_128_ER_01\test';

%% load QMDCT coefficients
[QMDCT_num, files_num] = deal(576, 1038);
QMDCT_matrices_cover = qmdct_extraction_batch1(QMDCT_files_path_cover, QMDCT_num, files_num);
QMDCT_matrices_stego = qmdct_extraction_batch1(QMDCT_files_path_stego, QMDCT_num, files_num);

%% feature extraction
% feature type: ADOPT(Jin), MDI2(Ren), JPBC(Wang-IS), I2C(Wang-CIHW), D2MA(Qiao), Occurance(Yan)
feature_type = 'ADOTP';
feature_cover = feature_extraction_batch(QMDCT_matrices_cover, feature_type);
feature_stego = feature_extraction_batch(QMDCT_matrices_stego, feature_type);

%% train and validation
percent = 0.6;
times = 100;
ACC_sum = 0;
for i = 1:times
    result = training(feature_cover, feature_stego, 0.6);
    ACC_sum = ACC_sum + result.ACC;
end

ACC_AVERAGE = ACC / times;

% fprintf('feature type: %s\n', feature_type);
% fprintf('FPR: %4.2f%%, FNR: %4.2f%%, ACC: %4.2f%%\r\n', 100*result.FPR, 100*result.FNR, 100*result.ACC);

fprintf('feature type: %s\n', feature_type);
fprintf('Average Accuracy: %4.2f%%\r\n', 100*result.ACC);