%% text file path
QMDCT_files_path_cover = '';
QMDCT_files_path_stego = '';

%% load QMDCT coefficients
[QMDCT_num, files_num] = deal(576, 5);
QMDCT_matrices_cover = qmdct_extraction_batch1(QMDCT_files_path_cover, QMDCT_num, files_num);
QMDCT_matrices_stego = qmdct_extraction_batch1(QMDCT_files_path_stego, QMDCT_num, files_num);

%% feature extraction
% feature type: ADOPT(Jin), MDI2(Ren), JPBC(Wang-IS), I2C(Wang-CIHW), D2MA(Qiao), Occurance(Yan)
feature_type = 'ADOPT';
feature_cover = feature_extraction_batch(QMDCT_matrices_cover, feature_type);
feature_stego = feature_extraction_batch(QMDCT_matrices_stego, feature_type);

%% train and validation
percent = 0.8;
result = training(feature_cover, feature_stego, percent);
fprintf('feature type: %s\n', feature_type);
fprintf('FPR: %4.2f%%, FNR: %4.2f%%, ACC: %4.2f%%\r\n', 100*result.FPR, 100*result.FNR, 100*result.ACC);