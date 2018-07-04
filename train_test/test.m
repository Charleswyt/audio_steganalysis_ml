%% test
% - result = test(cover_feature, stego_feature, model_file_path)
% - Variable:
% ------------------------------------------input
% cover_feature         the feature of cover samples
% stego_feature         the feature of stego samples
% model_file_path       the path of model file
% -----------------------------------------output
% result                result
%    FPR                False positive rate
%    FNR                False negative rate
%    ACC                Accuracy
% model                 model
% predict_label         predictal label
% ground_truth          real label
function [result, error_id] = test(cover_feature, stego_feature, model_file_path)

sample_num_cover = size(cover_feature, 1);                                  % the number of cover samples
sample_num_stego = size(stego_feature, 1);                                  % the number of stego samples

cover_label = -ones(sample_num_cover, 1);                                   % cover label
stego_label =  ones(sample_num_stego, 1);                                   % steog label
feature = [cover_feature; stego_feature];                                   % feature
label = [cover_label; stego_label];                                         % label

% load model file
model_file = load(model_file_path);
model = model_file.model;

predict = libsvmpredict(label, feature, model);                             % svm predict
error_id = find(predict ~= label);                                          % find error file ID

FP = sum(test_label == -1 & predict ==  1);                                 % False Positive
FN = sum(test_label ==  1 & predict == -1);                                 % False Negative
TP = sum(test_label ==  1 & predict ==  1);                                 % True  Positive
TN = sum(test_label == -1 & predict == -1);                                 % True  Positive

FPR = FP / (FP + TN);                                                       % False Positive Rate
FNR = FN / (TP + FN);                                                       % False Negative Rate
ACC = 1 - ((FPR + FNR) / 2);                                                % Accuracy

result.FPR = FPR;result.FNR = FNR;result.ACC = ACC;