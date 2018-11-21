%% text file path
QMDCT_files_path_cover = '';
QMDCT_files_path_stego = '';

%% load QMDCT coefficients
[QMDCT_num, files_num] = deal(450, 1000);
% QMDCT_matrices_cover = qmdct_extraction_batch1(QMDCT_files_path_cover, QMDCT_num, files_num);
% QMDCT_matrices_stego = qmdct_extraction_batch1(QMDCT_files_path_stego, QMDCT_num, files_num);

%% feature extraction
% feature type: ADOTP(Jin), MDI2(Ren), JPBC(Wang-IS), I2C(Wang-CIHW), D2MA(Qiao), Occurance(Yan)
feature_type = 'MDI2';
% feature_cover = feature_extraction_batch(QMDCT_matrices_cover, feature_type);
% feature_stego = feature_extraction_batch(QMDCT_matrices_stego, feature_type);

%% train and validation
% classifier type: svm, ensemble_classifier
classifier_type = 'svm';
[percent, times, ACC_sum] = deal(0.6, 1, 0);

if strcmp(classifier_type, 'svm')
    try
        for i = 1:times
            [result, model] = training_svm(feature_cover, feature_stego, percent);
            ACC_sum = ACC_sum + result.ACC;
        end
    catch
        fprintf('SVM Training Error.\n');
    end
elseif strcmp(classifier_type, 'ensemble_classifier')
    try
        for i = 1:times
            [result, trained_ensemble] = training_ensemble(feature_cover, feature_stego, percent);
            ACC_sum = ACC_sum + result.ACC;
        end
    catch
        fprintf('Ensemble Training Error.\n');
    end
else
    fprintf('Error in classifier selection.\n');
    ACC = 0;
end

ACC_average = ACC_sum / times;
fprintf('feature type: %s\n', feature_type);
fprintf('Average Accuracy: %4.2f%%\r\n', 100*ACC_average);