%% steganalysis for person
% - steganalysis_person(bitrate, algorithm, feature_type, width, RER, is_known, feature_cover_mat_dir, feature_stego_mat_dir, model_files_path)
% - Variable:
% ------------------------------------------input
% bitrate               bitrate of audio for test
% algorithm             algorithm type, (option: 'MP3Stego', 'HCM', 'EECS', 'ACS')
% feature_type          feature type, (option: 'jin', 'ren', 'wang')
% width                 relative payload for 'EECS' and 'ACS' (option: 2, 4, 6)
% is_known              whether algorithm is known or not (option: 'True', 'False')
% model_files_path      path of model files
% feature_cover_mat_dir directory of cover feature
% feature_stego_mat_dir directory of stego feature
% -----------------------------------------output
% Null

function steganalysis_person(bitrate, algorithm, feature_type, width, is_known, feature_cover_mat_dir, feature_stego_mat_dir, model_files_path)

% load feature data
cover_feature_path = fullfile(feature_cover_mat_dir, feature_type, num2str(bitrate));
stego_feature_path = fullfile(feature_stego_mat_dir, algorithm, feature_type, [algorithm, '_B_', num2str(bitrate), '_W_', num2str(width), '_H_7_ER_10']);

cover_feature_file = load(cover_feature_path);
stego_feature_file = load(stego_feature_path);

cover_feature = cover_feature_file.features;cover_feature = cover_feature(801:1000,:);
stego_feature = stego_feature_file.features;stego_feature = stego_feature(801:1000,:);

% load model file
if strcmp(is_known, 'True')
    model_file_name = [algorithm, '_', feature_type];
else
    model_file_name = ['UNKNOWN_', feature_type];
end
model_file_path = fullfile(model_files_path, model_file_name);

model_file = load(model_file_path);
model = model_file.model;

threshold = -15;
times = 500;
[FP, FN, TP, TN] = deal(0, 0, 0, 0);

for i = 1:times
    sample_num_cover = size(cover_feature, 1);                              % the number of cover samples
    sample_num_stego = size(stego_feature, 1);                              % the number of stego samples
    feature_dimension = size(cover_feature, 2);                             % the dimension of feature
    cover_label = -ones(sample_num_cover, 1);                               % cover label
    stego_label = ones(sample_num_stego, 1);                                % steog label
    cover_data = [cover_feature, cover_label];                              % cover data [feature, label]
    stego_data = [stego_feature, stego_label];                              % stego data [feature, label]
    merge = [cover_data; stego_data];                                       % data and label pair
    merge = shuffle(merge);                                                 % data shuffle

    data  = merge(:, 1:feature_dimension);                                  % training data
    label = merge(:, feature_dimension+1);                                  % training label

    number = 50;                                                            % number in a group
    sample_num = sample_num_cover + sample_num_stego;                       % total number for experiments

    index = randperm(sample_num, number);index = index';                    % generate random number
    predict_data = data(index, :);predict_label = label(index, :);
    [~, ~, prob] = libsvmpredict(predict_label, predict_data, model, '-b 1');
    prob_cover = prob(:,2);prob_steog = prob(:,1);                          % get prob estimation
    single_likelihood_ratio = prob_cover ./ prob_steog;                     % calculate likelihood ratio of single sample
    multi_likelihood_ratio = 1;
    for j = 1:number
        multi_likelihood_ratio = multi_likelihood_ratio * single_likelihood_ratio(j);
    end
    multi_likelihood_ratio_stego = log(multi_likelihood_ratio + eps);       % calculate likelihood ratio of multi samples
   
    if multi_likelihood_ratio_stego <= threshold && ~isempty(find(predict_label == -1, 1))
        TP = TP + 1;
    elseif multi_likelihood_ratio_stego <= threshold && isempty(find(predict_label == -1, 1))
        FP = FP + 1;
    elseif multi_likelihood_ratio_stego > threshold && ~isempty(find(predict_label == -1, 1))
        FN = FN + 1;
    else
        TN = TN + 1;
    end
end
TP, TN
FPR = FP / (FP + TN + eps);                                                 % False Positive Rate
FNR = FN / (TP + FN + eps);                                                 % False Negative Rate
ACC = 1 - ((FPR + FNR) / 2);                                                % Accuracy

fprintf('FPR: %.3f%%, FNR %.3f%%, ACC: %.3f%%\n', FPR*100, FNR*100, ACC*100);