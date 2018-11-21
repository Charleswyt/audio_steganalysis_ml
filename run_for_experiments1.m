bitrates = [128, 320];
RER = {'01', '03', '05'};
feature_types = {'ADOTP', 'MDI2'};
fp=fopen('HCM_results.txt','a');

for b = 1:length(bitrates)
    for r = 1:length(RER)
        for f = 1:length(feature_types)
           %% text file path
            QMDCT_files_path_cover = ['E:\Myself\2.database\10.QMDCT\cover\cover_10s\', num2str(bitrates(b)), '\train'];
            QMDCT_files_path_stego = ['E:\Myself\2.database\10.QMDCT\stego\HCM\HCM_B_', num2str(bitrates(b)), '_ER_', RER{r}, '\train'];

           %% load QMDCT coefficients
            [QMDCT_num, files_num] = deal(450, 1038);
            QMDCT_matrices_cover = qmdct_extraction_batch1(QMDCT_files_path_cover, QMDCT_num, files_num);
            QMDCT_matrices_stego = qmdct_extraction_batch1(QMDCT_files_path_stego, QMDCT_num, files_num);

           %% feature extraction
            % feature type: ADOTP(Jin), MDI2(Ren), JPBC(Wang-IS), I2C(Wang-CIHW), D2MA(Qiao), Occurance(Yan)
            feature_type = feature_types{f};
            feature_cover = feature_extraction_batch(QMDCT_matrices_cover, feature_type);
            feature_stego = feature_extraction_batch(QMDCT_matrices_stego, feature_type);

           %% train and validation
            % classifier type: svm, ensemble_classifier
            classifier_type = 'svm';
            [percent, times, ACC_sum] = deal(0.6, 100, 0);

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
            fprintf(fp,'feature_type: %s, bitrate: %d, RER: %s, Accuracy: %.2f\n', feature_type, bitrates(b), RER{r}, 100*ACC_average);
        end
    end
end
fclose(fp);