%% calculate likelihood ratio for steganography

% model_file_path = 'E:\Myself\1.source_code\audio_steganalysis_ml\models\stego.mat';
% multi_likelihood_ratio_cover = get_likelihood_ratio_cover(cover_feature, model_file_path);
% multi_likelihood_ratio_stego = get_likelihood_ratio_stego(cover_feature, stego_feature, model_file_path);

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

times = 5000;
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

times = 5000;
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
