%% steganalysis for person (train step)
% - get_likelihood_ratio(bitrate, algorithm, feature_type, width, RER, is_known, feature_cover_mat_dir, feature_stego_mat_dir, model_files_path)
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

function get_likelihood_ratio(bitrate, algorithm, feature_type, width, is_known, feature_cover_mat_dir, feature_stego_mat_dir, model_files_path)

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

% find best threshold
multi_likelihood_ratio_cover = get_likelihood_ratio_cover(cover_feature, model_file_path);
multi_likelihood_ratio_stego = get_likelihood_ratio_stego(cover_feature, stego_feature, model_file_path);

% plot the hist
[n1,x1] = hist(multi_likelihood_ratio_cover, 3 * (max(multi_likelihood_ratio_cover) - min(multi_likelihood_ratio_cover)));
[n2,x2] = hist(multi_likelihood_ratio_stego, 3 * (max(multi_likelihood_ratio_stego) - min(multi_likelihood_ratio_stego)));
[~,h1,h2]=plotyy(x1,n1,x2,n2,@bar,@bar);
set(h1,'facecolor','r');
set(h2,'facecolor','b');
legend('cover', 'stego');

end

%% get_likelihood_ratio_stego
% - multi_likelihood_ratio_stego = get_likelihood_ratio_stego(cover_feature, stego_feature, model_file_path)
% - Variable:
%------------------------------------------input
% cover_feature                 the feature of cover samples
% stego_feature                 the feature of stego samples
% model_file_path               the path of model
%-----------------------------------------output
% multi_likelihood_ratio_cover  likelihood ratio for cover samples

function multi_likelihood_ratio_cover = get_likelihood_ratio_cover(cover_feature, model_file_path)

sample_num_cover = size(cover_feature, 1);                                  % the number of cover samples
feature_dimension = size(cover_feature, 2);                                 % the dimension of feature
cover_label = -ones(sample_num_cover, 1);                                   % cover label
cover_data = [cover_feature, cover_label];                                  % cover data [feature, label]
merge = shuffle(cover_data);                                                % data shuffle

data  = merge(:, 1:feature_dimension);                                      % training data
label = merge(:, feature_dimension+1);                                      % training label

number = 50;                                                                % number in a group
sample_num = sample_num_cover;                                              % total number for experiments

times = 1000;
multi_likelihood_ratio_cover = zeros(1, 500);

for i = 1:times
    index = randperm(sample_num, number);index = index';                    % generate random number
    predict_data = data(index, :);predict_label = label(index, :);
    model = load(model_file_path);model = model.model;                      % load svm model
    [~, ~, prob] = libsvmpredict(predict_label, predict_data, model, '-b 1');
    prob_cover = prob(:,2);prob_steog = prob(:,1);                          % get prob estimation
    single_likelihood_ratio = prob_cover ./ prob_steog;                     % calculate likelihood ratio of single sample
    multi_likelihood_ratio = 1;
    for j = 1:number
        multi_likelihood_ratio = multi_likelihood_ratio * single_likelihood_ratio(j);
    end
    multi_likelihood_ratio_cover(i) = log(multi_likelihood_ratio + eps);    % calculate likelihood ratio of multi samples
end

end
%% get_likelihood_ratio_stego
% - multi_likelihood_ratio_stego = get_likelihood_ratio_stego(cover_feature, stego_feature, model_file_path)
% - Variable:
%------------------------------------------input
% cover_feature                 the feature of cover samples
% stego_feature                 the feature of stego samples
% model_file_path               the path of model
%-----------------------------------------output
% multi_likelihood_ratio_stego  likelihood ratio for stego samples

function multi_likelihood_ratio_stego = get_likelihood_ratio_stego(cover_feature, stego_feature, model_file_path)

sample_num_cover = size(cover_feature, 1);                                  % the number of cover samples
sample_num_stego = size(stego_feature, 1);                                  % the number of stego samples
feature_dimension = size(cover_feature, 2);                                 % the dimension of feature
cover_label = -ones(sample_num_cover, 1);                                   % cover label
stego_label = ones(sample_num_stego, 1);                                    % steog label
cover_data = [cover_feature, cover_label];                                  % cover data [feature, label]
stego_data = [stego_feature, stego_label];                                  % stego data [feature, label]
merge = [cover_data; stego_data];                                           % data and label pair
merge = shuffle(merge);                                                     % data shuffle

data  = merge(:, 1:feature_dimension);                                      % training data
label = merge(:, feature_dimension+1);                                      % training label

number = 50;                                                                % number in a group
sample_num = sample_num_cover + sample_num_stego;                           % total number for experiments

times = 1000;
multi_likelihood_ratio_stego = zeros(1, 500);

for i = 1:times
    index = randperm(sample_num, number);index = index';                    % generate random number
    predict_data = data(index, :);predict_label = label(index, :);
    model = load(model_file_path);model = model.model;                      % load svm model
    [~, ~, prob] = libsvmpredict(predict_label, predict_data, model, '-b 1');
    prob_cover = prob(:,2);prob_steog = prob(:,1);                          % get prob estimation
    single_likelihood_ratio = prob_cover ./ prob_steog;                     % calculate likelihood ratio of single sample
    multi_likelihood_ratio = 1;
    for j = 1:number
        multi_likelihood_ratio = multi_likelihood_ratio * single_likelihood_ratio(j);
    end
    multi_likelihood_ratio_stego(i) = log(multi_likelihood_ratio + eps);    % calculate likelihood ratio of multi samples
end

end