%% training (训练分类)
% - [result, model] = training(cover_feature, stego_feature, percent, n)
% - Variable：
% ------------------------------------------input
% cover_feature         the feature of cover samples (cover特征)
% stego_feature         the feature of stego samples (stego特征)
% percent               the percent of training set, default is 0.8 (训练集所占百分比, 默认为0.8)
% n                     the times of cross-validation default is 10 (交叉验证次数, 默认为10)
% model_file_name       the file name of model
% is_rewrite            whether to rewrite the model file (是否将当前模型文件重写, 默认关闭)
% -----------------------------------------output
% result                result (分类结果)
%    FPR                False positive rate (虚警率)
%    FNR                False negative rate (漏报率)
%    ACC                Accuracy (准确率)
% model                 model (训练模型)
% predict_label         predictal label (预测标签)
% ground_truth          real label (真实标签)

function [result, model, predict_label, ground_truth] = training(cover_feature, stego_feature, percent, n, model_file_name, is_rewrite)

% 默认参数配置
if nargin < 2
    fprintf('请输出特征向量.\n');
elseif nargin == 2
    percent = 0.8;
    n = 10;
    model_file_name = 'model.mat';
    is_rewrite = 'False';
elseif nargin == 3
    n = 10;
    model_file_name = 'model.mat';
    is_rewrite = 'False';
    if percent >= 1
        percent = 0.8;
    end
elseif nargin == 4
    model_file_name = 'model.mat';
    is_rewrite = 'False';
else
    is_rewrite = 'False';
end 

sample_num = size(cover_feature, 1);                                        % the number of samples (样本个数)
train_set_number = floor(percent * sample_num);                             % the number of training set (训练集大小)
feature_dimension = size(cover_feature, 2);                                 % the dimension of feature (特征维度)

cover_label = -ones(sample_num, 1);                                         % cover label (cover样本标签)
stego_label =  ones(sample_num, 1);                                         % steog label (stego样本标签)
feature = [cover_feature; stego_feature];                                   % feature (训练数据特征)
label = [cover_label; stego_label];                                         % label (训练数据标签)
data = [feature, label];                                                    % data and label pair (用于svm的数据)

FPR = zeros(1, n);                                                          % the initialization of FPR (虚警率初始化)
FNR = zeros(1 ,n);                                                          % the initialization of FNR (漏报率初始化)
ACC = zeros(1 ,n);                                                          % the initialization of ACC (准确率初始化)

predict_label = [];                                                         % the initialization of test label (测试集样本分类标签)
ground_truth  = [];                                                         % the initialization of real label (测试集样本实际标签)

for i = 1 : n
    
    temp = shuffle(data);                                                   % the shuffle of training data (数据乱序)
    
    %% 制备训练集 | 测试集
    train_data  = temp(1:train_set_number, 1:feature_dimension);            % training data (训练集)
    train_label = temp(1:train_set_number, feature_dimension+1);            % training label (训练集标签)
    test_data   = temp(train_set_number+1:end, 1:feature_dimension);        % test data (测试集)
    test_label  = temp(train_set_number+1:end, feature_dimension+1);        % test label (测试集标签)
    
    %% SVM训练
    svm_params = '-s 0 -t 0 -g 10 -c 200';
    model(i)   = libsvmtrain(train_label, train_data, svm_params);          %#ok<AGROW>
    
    %% SVM预测
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
save(model_file_name, 'model');

fprintf('---------------------------------------------------\n');
fprintf('Training set: %d%% Test set: %d%% %d-cross validtion\n', percent*100, 100-percent*100, n);
fprintf('FPR: %.3f%%, FNR %.3f%%, ACC: %.3f%%\n', result.FPR * 100, result.FNR * 100, result.ACC * 100);
fprintf('The model file is saved as "%s"\n', model_file_name);
fprintf('Current time: %s\n', datestr(now, 0));