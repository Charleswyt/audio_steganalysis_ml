%% Get the best parameters of SVM
% - [best_acc, best_t, best_c, best_g] = get_best_params(cover_feature, stego_feature, percent)
% - Variable:
% ------------------------------------------input
% cover_feature         the path of audio file
% stego_feature         the algorithm of audio steganalysis
% percent               the percent of training set, default is 0.8
% -----------------------------------------output
% best_acc: the best accuracy
% best_t  : the best t
% best_c  : the best c
% best_g  : the best g

function [best_acc, best_t, best_c, best_g] = get_best_params(cover_feature, stego_feature, percent)

data = [cover_feature; stego_feature];
cover_label = zeros(size(cover_feature, 1), 1);
stego_label = ones(size(stego_feature, 1), 1);
label = [cover_label; stego_label];

number = size(data, 1);                                                     % 样本个数
dimension = size(data, 2);                                                  % 特征维度
temp = [data, label];
temp = shuffle(temp);

train_set_number = floor(percent * number);                                 % 训练集大小
train_data = temp(1 : train_set_number, 1:dimension);                       % 训练集
train_label = temp(1 : train_set_number, dimension + 1);                    % 训练集标签
[best_acc, best_t, best_c, best_g] = SVM(train_label,train_data, -10, 10, -5, 5, 3, 1, 1, 1);