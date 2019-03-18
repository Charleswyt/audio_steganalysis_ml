%% text file path
QMDCT_files_path_cover = 'E:\Myself\2.database\3.cover\cover_10s\128';
QMDCT_files_path_stego = 'E:\Myself\2.database\4.stego\EECS\EECS_B_128_W_2_H_7_ER_10';
model_file_name = 'model_EECS_B_128_W_2_H_7.mat';

%% load QMDCT coefficients
[QMDCT_num, start_index, files_num] = deal(400, 1, 5000);
% QMDCT_matrices_cover = qmdct_extraction_batch1(QMDCT_files_path_cover, QMDCT_num, start_index, files_num);
% QMDCT_matrices_stego = qmdct_extraction_batch1(QMDCT_files_path_stego, QMDCT_num, start_index, files_num);

%% feature extraction
% feature type: ADOTP(Jin), MDI2(Ren), JPBC(Wang-IS), I2C(Wang-CIHW), D2MA(Qiao), Occurance(Yan)
feature_type = 'JPBC';
feature_cover = feature_extraction_batch(QMDCT_matrices_cover, feature_type, 7);
feature_stego = feature_extraction_batch(QMDCT_matrices_stego, feature_type, 7);

%% train and validation
% classifier type: svm, ensemble_classifier
classifier_type = 'ensemble_classifier';
[percent, times, ACC_sum, FPR_sum, FNR_sum] = deal(0.6, 1, 0, 0, 0);

if strcmp(classifier_type, 'svm')
    try
        for i = 1:times
            [result, model] = training_svm(feature_cover, feature_cover, percent);
            ACC_sum = ACC_sum + result.ACC;
            FPR_sum = FPR_sum + result.FPR;
            FNR_sum = FNR_sum + result.FNR;
        end
    catch
        fprintf('SVM Training Error.\n');
    end
elseif strcmp(classifier_type, 'ensemble_classifier')
    try
        for i = 1:times
            [result, trained_ensemble] = training_ensemble(feature_cover, feature_stego, percent, 'False', model_file_name);
            ACC_sum = ACC_sum + result.ACC;
            FPR_sum = FPR_sum + result.FPR;
            FNR_sum = FNR_sum + result.FNR;
        end
    catch
        fprintf('Ensemble Training Error.\n');
    end
else
    fprintf('Error in classifier selection.\n');
    ACC = 0;
end

ACC_average = ACC_sum / times;
FPR_average = FPR_sum / times;
FNR_average = FNR_sum / times;

fprintf('feature type: %s\n', feature_type);
fprintf('Average Accuracy: %4.2f%%, FPR: %4.2f%%, FNR: %4.2f%%\r\n', 100 * ACC_average, 100 * FPR_average, 100 * FNR_average);