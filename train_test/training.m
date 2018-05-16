%% training
% - [result, model, predict_label, ground_truth] = ...
%           training(cover_feature, stego_feature, percent, n, model_file_name, is_rewrite)
% - Variable:
% ------------------------------------------input
% cover_feature         the feature of cover samples
% stego_feature         the feature of stego samples
% percent               the percent of training set, default is 0.8
% n                     the times of cross-validation default is 10
% model_file_name       the file name of model
% svm_params            svm parameters for training
% seek_best_paarams     whether seek the optimal parameters for training
% is_rewrite            whether to rewrite the model file
% -----------------------------------------output
% result                result
%    FPR                False positive rate
%    FNR                False negative rate
%    ACC                Accuracy
% model                 model
% predict_label         predictal label
% ground_truth          real label

function [result, model, predict_label, ground_truth] ...
    = training(cover_feature, stego_feature, percent, n, model_file_name, seek_best_params, svm_params, is_rewrite)

% default parameters
if ~exist('percent', 'var') || isempty(percent)
    percent = 0.8;
end

if ~exist('n', 'var') || isempty(n)
    n = 0.8;
end

if ~exist('model_file_name', 'var') || isempty(model_file_name)
    model_file_name = 'model.mat';
end

if ~exist('is_rewrite', 'var') || isempty(is_rewrite)
    is_rewrite = 'False';
end

if ~exist('seek_best_params', 'var') || isempty(seek_best_params)
    seek_best_params = 'False';
end

if ~exist('svm_params', 'var') || isempty(svm_params)
    if strcmp(seek_best_params, 'False')
        svm_params = '-s 0 -t 0 -c 512 -g 0.0313';
    elseif strcmp(seek_best_params, 'True')
        [best_acc, best_t, bestc, bestg] = get_best_params(cover_feature, stego_feature, percent);
        svm_params = ['-s 0 -t ', num2str(best_t), '-c ', num2str(bestc), ' -g ', num2str(bestg)];
    end
end

sample_num = size(cover_feature, 1);                                        % the number of samples
train_set_number = 2 * floor(percent * sample_num);                         % the number of training set
feature_dimension = size(cover_feature, 2);                                 % the dimension of feature

cover_label = -ones(sample_num, 1);                                         % cover label
stego_label =  ones(sample_num, 1);                                         % steog label
feature = [cover_feature; stego_feature];                                   % feature
label = [cover_label; stego_label];                                         % label
data = [feature, label];                                                    % data and label pair

FPR = zeros(1, n);                                                          % the initialization of FPR
FNR = zeros(1 ,n);                                                          % the initialization of FNR
ACC = zeros(1 ,n);                                                          % the initialization of ACC

predict_label = [];                                                         % the initialization of test label
ground_truth  = [];                                                         % the initialization of real label

for i = 1 : n
    
    temp = shuffle(data);                                                   % the shuffle of training data

    %% make data
    train_data  = temp(1:train_set_number, 1:feature_dimension);            % training data
    train_label = temp(1:train_set_number, feature_dimension+1);            % training label
    test_data   = temp(train_set_number+1:end, 1:feature_dimension);        % test data
    test_label  = temp(train_set_number+1:end, feature_dimension+1);        % test label
    
    %% SVM training
    model(i)    = libsvmtrain(train_label, train_data, svm_params);         %#ok<AGROW>
    
    %% SVM validation
    predict = libsvmpredict(test_label, test_data, model(i));
    predict_label = [predict_label; predict];                               %#ok<AGROW>
    ground_truth  = [ground_truth; test_label];                             %#ok<AGROW>
    
    FP = sum(test_label == -1 & predict ==  1);                             % False Positive
    FN = sum(test_label ==  1 & predict == -1);                             % False Negative
    TP = sum(test_label ==  1 & predict ==  1);                             % True  Positive
    TN = sum(test_label == -1 & predict == -1);                             % True  Positive
        
    FPR(i) = FP / (FP + TN);                                                % False Positive Rate
    FNR(i) = FN / (TP + FN);                                                % False Negative Rate
    ACC(i) = 1 - ((FPR(i) + FNR(i)) / 2);                                   % Accuracy
    
    %% save the model file (保存模型文件)
    if strcmp(is_rewrite, 'True') == 1
        
        if ~exist(model_file_name, 'file')
            save(model_file_name, 'model', '-append');
        else
            save(model_file_name, 'model');
        end
    else
        continue;
    end
end

result.FPR = mean(FPR);
result.FNR = mean(FNR);
result.ACC = mean(ACC);
result.svm_params = svm_params;
result.best_acc = best_acc;
save(model_file_name, 'model');

fprintf('---------------------------------------------------\n');
fprintf('Training set: %d%%, Test set: %d%%, %d cross validtion\n', percent*100, 100-percent*100, n);
fprintf('FPR: %.3f%%, FNR %.3f%%, ACC: %.3f%%\n', result.FPR * 100, result.FNR * 100, result.ACC * 100);
fprintf('The model file is saved as "%s"\n', model_file_name);
fprintf('Current time: %s\n', datestr(now, 0));