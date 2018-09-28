%% steganalysis for audio
% - steganalyis_audio(bitrate, algorithm, feature_type, width, RER, is_known, feature_cover_mat_dir, feature_stego_mat_dir, model_files_path)
% - Variable:
% ------------------------------------------input
% bitrate               bitrate of audio for test
% algorithm             algorithm type, (option: 'MP3Stego', 'HCM', 'EECS', 'ACS')
% feature_type          feature type, (option: 'jin', 'ren', 'wang')
% width                 relative payload for 'EECS' and 'ACS' (option: 2, 4, 6)
% RER                   relative embedding rate (just for 'MP3Stego' and 'HCM', option: '01', '03', '05', '08', '10')
% is_known              whether algorithm is known or not (option: 'True', 'False')
% model_files_path      path of model files
% feature_cover_mat_dir directory of cover feature
% feature_stego_mat_dir directory of stego feature
% -----------------------------------------output
% Null

function steganalysis_audio(bitrate, algorithm, feature_type, width, RER, is_known, feature_cover_mat_dir, feature_stego_mat_dir, model_files_path)

% load feature data
if strcmp(algorithm, 'MP3Stego')
    cover_feature_path = fullfile(feature_cover_mat_dir, feature_type, ['mp3stego_', num2str(bitrate)]);
    stego_feature_path = fullfile(feature_stego_mat_dir, algorithm, feature_type, ['MP3Stego_B_', num2str(bitrate), '_ER_', RER]);
elseif strcmp(algorithm, 'HCM')
    cover_feature_path = fullfile(feature_cover_mat_dir, feature_type, num2str(bitrate));
    stego_feature_path = fullfile(feature_stego_mat_dir, algorithm, feature_type, ['HCM_B_', num2str(bitrate), '_ER_', RER]);
else
    cover_feature_path = fullfile(feature_cover_mat_dir, feature_type, num2str(bitrate));
    stego_feature_path = fullfile(feature_stego_mat_dir, algorithm, feature_type, [algorithm, '_B_', num2str(bitrate), '_W_', num2str(width), '_H_7_ER_', RER]);
end

cover_feature_file = load(cover_feature_path);
stego_feature_file = load(stego_feature_path);

cover_feature = cover_feature_file.features;cover_feature = cover_feature(601:1000,:);
stego_feature = stego_feature_file.features;stego_feature = stego_feature(601:1000,:);

% load model file
if strcmp(is_known, 'True')
    model_file_name = [algorithm, '_', feature_type];
else
    model_file_name = ['UNKNOWN_', feature_type];
end
model_file_path = fullfile(model_files_path, model_file_name);

model_file = load(model_file_path);
model = model_file.model;

sample_num_cover = size(cover_feature, 1);                                  % the number of cover samples
sample_num_stego = size(stego_feature, 1);                                  % the number of stego samples
feature_dimension = size(cover_feature, 2);                                 % the dimension of feature
cover_label = -ones(sample_num_cover, 1);                                   % cover label
stego_label = ones(sample_num_stego, 1);                                    % steog label
cover_data = [cover_feature, cover_label];                                  % cover data [feature, label]
stego_data = [stego_feature, stego_label];                                  % stego data [feature, label]
merge = [cover_data; stego_data];                                           % data and label pair

fpr = zeros(1, 10);
fnr = zeros(1, 10);
acc = zeros(1, 10);

for i = 1:10
    merge = shuffle(merge);                                                 % data shuffle

    data  = merge(1:100, 1:feature_dimension);                              % training data
    label = merge(1:100, feature_dimension+1);                              % training label
    predict = libsvmpredict(label, data, model, '-b 1');

    FP = sum(label == -1 & predict ==  1);                                  % False Positive
    FN = sum(label ==  1 & predict == -1);                                  % False Negative
    TP = sum(label ==  1 & predict ==  1);                                  % True  Positive
    TN = sum(label == -1 & predict == -1);                                  % True  Positive

    fpr(i) = FP / (FP + TN);                                                % False Positive Rate
    fnr(i) = FN / (TP + FN);                                                % False Negative Rate
    acc(i) = 1 - ((fpr(i) + fnr(i)) / 2);                                   % Accuracy
end

FPR = mean(fpr);
FNR = mean(fnr);
ACC = mean(acc);

% display the result
if strcmp(algorithm, 'MP3Steog') || strcmp(algorithm, 'HCM')
    fprintf('Algorithm: %s, bitrate: %d, RER: %s\nfeature type: %s\n', algorithm, bitrate, RER, feature_type);
else
    fprintf('Algorithm: %s, bitrate: %d, width: %d\nfeature type: %s\n', algorithm, bitrate, width, feature_type);
end
fprintf('False positive rate: %.2f%%\n', 100*FPR);
fprintf('False negative rate: %.2f%%\n', 100*FNR);
fprintf('accuracy rate: %.2f%%\n', 100*ACC);

end