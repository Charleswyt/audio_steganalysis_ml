bitrates = [128, 320];
widths = [2, 3, 4, 5, 6, 7];
feature_types = {'ADOTP', 'MDI2'};
fp=fopen('EECS_results.txt','a');

[QMDCT_num, files_num] = deal(450, 2000);
for b = 1:length(bitrates)
    %% text file path and load QMDCT coefficients
    QMDCT_files_path_cover = ['E:\Myself\2.database\10.QMDCT\cover\cover_10s\', num2str(bitrates(b)), '\train'];
    QMDCT_matrices_cover = qmdct_extraction_batch1(QMDCT_files_path_cover, QMDCT_num, files_num);
    
    for w = 1:length(widths)
        for f = 1:length(feature_types)
           %% text file path and load QMDCT coefficients
            QMDCT_files_path_stego = ['E:\Myself\2.database\10.QMDCT\stego\EECS\EECS_B_', num2str(bitrates(b)), '_W_', num2str(widths(w)), '_H_7_ER_10\train'];
            QMDCT_matrices_stego = qmdct_extraction_batch1(QMDCT_files_path_stego, QMDCT_num, files_num);

           %% feature extraction
            % feature type: ADOTP(Jin), MDI2(Ren), JPBC(Wang-IS), I2C(Wang-CIHW), D2MA(Qiao), Occurance(Yan)
            feature_type = feature_types{f};
            feature_cover = feature_extraction_batch(QMDCT_matrices_cover, feature_type);
            feature_stego = feature_extraction_batch(QMDCT_matrices_stego, feature_type);

           %% train and validation
            % classifier type: svm, ensemble_classifier
            classifier_type = 'svm';
            [percent, times, ACC_sum] = deal(0.6, 5, 0);

            if strcmp(classifier_type, 'svm')
                try
                    for i = 1:times
                        [result, model] = training_svm(feature_cover, feature_stego, 0.6);
                        ACC_sum = ACC_sum + result.ACC;
                    end
                catch
                    fprintf('SVM Training Error.\n');
                end
            elseif strcmp(classifier_type, 'ensemble_classifier')
                try
                    for i = 1:times
                        [result, trained_ensemble] = training_ensemble(feature_cover, feature_stego, 0.6);
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
            fprintf(fp,'feature_type: %s, bitrate: %d, width: %d, Accuracy: %.2f\n', feature_type, bitrates(b), widths(w), 100*ACC_average);
        end
    end
end
fclose(fp);