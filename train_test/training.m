%% training
% - [result, prob, model, predict, ground_truth] = ...
%      training(cover_feature, stego_feature, percent, model_file_name, seek_best_params, svm_params, is_rewrite)
% - Variable:
%------------------------------------------input
% cover_feature         the feature of cover samples
% stego_feature         the feature of stego samples
% percent               the percent of training set, default is 0.8
% model_file_name       the file name of model
% svm_params            svm parameters for training
% seek_best_paarams     whether seek the optimal parameters for training
% is_rewrite            whether to rewrite the model file
%-----------------------------------------output
% result                result
%   FPR                 False positive rate
%   FNR                 False negative rate
%   ACC                 Accuracy
%   svm_params          svm params of current model
% prob                  probability estimates
% model                 svm model
% predict               predictal label
% ground_truth          real label

function [result, prob, model, predict, ground_truth] ...
    = training(cover_feature, stego_feature, percent, model_file_name, seek_best_params, svm_params, is_rewrite)

%default parameters
if ~exist('percent', 'var') || isempty(percent)
    percent = 0.8;
end

if ~exist('model_file_name', 'var') || isempty(model_file_name)
    model_file_name = strcat(inputname(2), '.mat');
end

if ~exist('is_rewrite', 'var') || isempty(is_rewrite)
    is_rewrite = 'False';
end

if ~exist('seek_best_params', 'var') || isempty(seek_best_params)
    seek_best_params = 'False';
end

if ~exist('svm_params', 'var') || isempty(svm_params)
    if strcmp(seek_best_params, 'False')
        svm_params = '-s 0 -t 2 -c 1024 -g 0.015'; %1024, 0.0313
    elseif strcmp(seek_best_params, 'True')
        [best_acc, best_t, bestc, bestg] = get_best_params(cover_feature, stego_feature);
        svm_params = ['-s 0 -t ', num2str(best_t), '-c ', num2str(bestc), ' -g ', num2str(bestg)];
    end
end

model_files_dir = 'E:\Myself\1.source_code\audio_steganalysis_ml\models';   % model files dir

sample_num_cover = size(cover_feature, 1);                                  % the number of cover samples
sample_num_stego = size(stego_feature, 1);                                  % the number of stego samples
train_set_number = 2 * floor(percent * sample_num_stego);                   % the number of training set
feature_dimension = size(cover_feature, 2);                                 % the dimension of feature

cover_label = -ones(sample_num_cover, 1);                                   % cover label
stego_label =  ones(sample_num_stego, 1);                                   % steog label
cover_data = [cover_feature, cover_label];                                  % cover data [feature, label]
stego_data = [stego_feature, stego_label];                                  % stego data [feature, label]
merge = [cover_data; stego_data];                                           % data and label pair
merge = shuffle(merge);                                                     % data shuffle

start_time = tic;

%% make data
train_data  = merge(1:train_set_number, 1:feature_dimension);               % training data
train_label = merge(1:train_set_number, feature_dimension+1);               % training label
test_data   = merge(train_set_number+1:end, 1:feature_dimension);           % test data
test_label  = merge(train_set_number+1:end, feature_dimension+1);           % test label

%% SVM training
model = libsvmtrain(train_label, train_data, svm_params);

%% SVM validation
[predict, ~, prob] = libsvmpredict(test_label, test_data, model);
ground_truth  = test_label;

FP = sum(test_label == -1 & predict ==  1);                                 % False Positive
FN = sum(test_label ==  1 & predict == -1);                                 % False Negative
TP = sum(test_label ==  1 & predict ==  1);                                 % True  Positive
TN = sum(test_label == -1 & predict == -1);                                 % True  Positive

FPR = FP / (FP + TN);                                                       % False Positive Rate
FNR = FN / (TP + FN);                                                       % False Negative Rate
ACC = 1 - ((FPR + FNR) / 2);                                                % Accuracy

%% save the model file
if strcmp(is_rewrite, 'True') == 1
    save(model_file_name, 'model');
end

result.FPR = FPR;
result.FNR = FNR;
result.ACC = ACC;
result.svm_params = svm_params;

if strcmp(seek_best_params, 'True')
    result.best_acc = best_acc;
else
    result.best_acc = mean(ACC);
end

model_file_path = fullfile(model_files_dir, model_file_name);
save(model_file_path, 'model');

end_time = toc(start_time);
fprintf('---------------------------------------------------\n');
fprintf('Training\n');
fprintf('Training set: %d%%, Test set: %d%%\n', percent*100, 100-percent*100);
fprintf('FPR: %.3f%%, FNR %.3f%%, ACC: %.3f%%\n', result.FPR*100, result.FNR*100, result.ACC*100);
fprintf('The model file is saved as "%s"\n', model_file_name);
fprintf('Feature loads completes, runtime: %.2fs\n', end_time);
fprintf('Current time: %s\n', datestr(now, 0));