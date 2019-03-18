%% hyper parameters
bitrates = [128, 192, 256, 320];
RER = {'01'};%, '03', '05', '08', '10'};
feature_types = {'ADOTP', 'MDI2', 'JPBC'};
[QMDCT_num, files_num] = deal(400, 1000);
classifier_type = 'ensemble_classifier';
[percent, times] = deal(0.6, 10);

%% file for results saving
time_stamp_format = '_yyyy_mm_dd_HH_MM_SS';
time_stamp = datestr(now, time_stamp_format);
results_dir = 'E:\Myself\1.source_code\audio_steganalysis_ml\results';
if ~exist(results_dir, 'file') mkdir(results_dir); end                      %#ok<SEPEX>
result_file_path = fullfile(results_dir, strcat('MP3Stego_results', time_stamp, '.txt'));
fp = fopen(result_file_path, 'w');

cover_files_dir = 'E:\Myself\2.database\3.cover\cover_10s\';
stego_files_dir = 'E:\Myself\2.database\4.stego\MP3Stego\';

for b = 1:length(bitrates)
    %% load QMDCT coefficients
    QMDCT_files_path_cover = [cover_files_dir, 'MP3Stego_', num2str(bitrates(b))];
    QMDCT_matrices_cover = qmdct_extraction_batch1(QMDCT_files_path_cover, QMDCT_num, files_num);
    
    for r = 1:length(RER)
       %% load QMDCT coefficients
        QMDCT_files_path_stego = [stego_files_dir, 'MP3Stego_B_', num2str(bitrates(b)), '_ER_', RER{r}];       
        QMDCT_matrices_stego = qmdct_extraction_batch1(QMDCT_files_path_stego, QMDCT_num, files_num);
        
       %% feature extraction
        for f = 1:length(feature_types)
            % feature type: ADOTP(Jin), MDI2(Ren), JPBC(Wang-IS), I2C(Wang-CIHW), D2MA(Qiao), Occurance(Yan)
            feature_type = feature_types{f};
            feature_cover = feature_extraction_batch(QMDCT_matrices_cover, feature_type);
            feature_stego = feature_extraction_batch(QMDCT_matrices_stego, feature_type);

           %% train and validation
            % classifier type: svm, ensemble_classifier
            [ACC_sum,FPR_sum, FNR_sum] = deal(0, 0, 0);
            if strcmp(classifier_type, 'svm')
                try
                    for i = 1:times
                        [result, model] = training_svm(feature_cover, feature_stego, percent);
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
                        [result, trained_ensemble] = training_ensemble(feature_cover, feature_stego, percent);
                        ACC_sum = ACC_sum + result.ACC;
                        FPR_sum = FPR_sum + result.FPR;
                        FNR_sum = FNR_sum + result.FNR;
                    end
                catch
                    fprintf('Ensemble Training Error.\n');
                end
            else
                fprintf('Error in classifier selection.\n');
            end

            ACC_average = ACC_sum / times;
            FPR_average = FPR_sum / times;
            FNR_average = FNR_sum / times;
            fprintf('feature type: %s\n', feature_type);
            fprintf('bitrate: %d, RER: %s\n', bitrates(b), RER{r});
            fprintf('%d-times Average FPR: %4.2f%%, FNR: %4.2f%%, ACC: %4.2f%%\r\n', times, 100*FPR_average, 100*FNR_average, 100*ACC_average);
            fprintf(fp,'feature_type: %s, bitrate: %d, RER: %s, FPR: %.2f%%, FNR: %.2f%%, ACC: %.2f%%\r\n', ...
                feature_type, bitrates(b), RER{r}, 100*FPR_average, 100*FNR_average, 100*ACC_average);
        end
    end
end
fclose(fp);