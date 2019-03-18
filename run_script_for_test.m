%% audio file path
QMDCT_files_path_cover = 'E:\Myself\2.database\3.cover\cover_10s\128';
QMDCT_files_path_stego = 'E:\Myself\2.database\blind_data\HCM_B_128_MIX';

%% load QMDCT coefficients
[QMDCT_num, start_index, files_num] = deal(400, 8000, 2000);
% QMDCT_matrices_cover = qmdct_extraction_batch1(QMDCT_files_path_cover, QMDCT_num, start_index, files_num);
% QMDCT_matrices_stego = qmdct_extraction_batch1(QMDCT_files_path_stego, QMDCT_num, start_index, files_num);

%% feature extraction
% feature type: ADOTP(Jin), MDI2(Ren), JPBC(Wang-IS), I2C(Wang-CIHW), D2MA(Qiao), Occurance(Yan)
feature_type = 'JPBC';
% feature_cover_ = feature_extraction_batch(QMDCT_matrices_cover, feature_type);
% feature_stego_ = feature_extraction_batch(QMDCT_matrices_stego, feature_type);

[ACC_sum, FPR_sum, FNR_sum] = deal(0, 0, 0);
times = 1;
%% test
% classifier type: svm, ensemble_classifier
classifier_type = 'ensemble_classifier';
model_file_path = 'E:\Myself\1.source_code\audio_steganalysis_ml\models\model_EECS_B_128_W_2_H_7_ER_10.mat';

if strcmp(classifier_type, 'svm')
    try
        result = test_svm(feature_cover_, feature_stego_, model_file_path);
        ACC_sum = ACC_sum + result.ACC;
    catch
        fprintf('SVM Test Error.\n');
    end
elseif strcmp(classifier_type, 'ensemble_classifier')
    try
        result = test_ensemble(feature_cover_, feature_stego_, model_file_path);
        ACC_sum = ACC_sum + result.ACC;
        FPR_sum = FPR_sum + result.FPR;
        FNR_sum = FNR_sum + result.FNR;
    catch
        fprintf('Ensemble Test Error.\n');
    end
else
    fprintf('Error in classifier selection.\n');
    ACC = 0;
end

% fprintf('feature type: %s\n', feature_type);
% fprintf('FPR: %4.2f%%, FNR: %4.2f%%, ACC: %4.2f%%\r\n', 100*result.FPR, 100*result.FNR, 100*result.ACC);

ACC_average = ACC_sum / times;
FPR_average = FPR_sum / times;
FNR_average = FNR_sum / times;
fprintf('feature type: %s\n', feature_type);
fprintf('%d Times - Average Accuracy: %4.2f%%, FPR: %4.2f%%, FNR: %4.2f%%\r\n', times, 100*ACC_average, 100*FPR_average, 100*FNR_average);