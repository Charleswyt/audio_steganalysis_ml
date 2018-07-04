%% test_batch
% - result = steganalysis_batch(cover_feature, stego_feature, model_file_dir)
% - Variable:
% ------------------------------------------input
% cover_feature         the feature of cover samples
% stego_feature         the feature of stego samples
% model_file_dir        the folder name of model files
% -----------------------------------------output
% result                result
%    FPR                False positive rate
%    FNR                False negative rate
%    ACC                Accuracy

function result = steganalysis_batch(cover_feature, stego_feature, model_file_path)

model_file_dir = 'E:\Myself\1.source_code\audio_steganalysis_ml\models';
if ~exist('model_file_path', 'var') || isempty(model_file_path)
    model_file_path = fullfile(model_file_dir, strcat(inputname(2), '.mat'));
end

sample_num_cover = size(cover_feature, 1);                                  % the number of cover samples
sample_num_stego = size(stego_feature, 1);                                  % the number of stego samples

cover_label = -ones(sample_num_cover, 1);                                   % cover label
stego_label =  ones(sample_num_stego, 1);                                   % steog label
data = [cover_feature; stego_feature];                                      % data and label pair
label = [cover_label; stego_label];                                         % label

% model = load_model_file(model_file_path);
models = load('model.mat');
model = models.model;
predict = svmpredict(label, data, model);

FP = sum(label == -1 & predict ==  1);                                      % False Positive
FN = sum(label ==  1 & predict == -1);                                      % False Negative
TP = sum(label ==  1 & predict ==  1);                                      % True  Positive
TN = sum(label == -1 & predict == -1);                                      % True  Positive

FPR = FP / (FP + TN);                                                       % False Positive Rate
FNR = FN / (TP + FN);                                                       % False Negative Rate
ACC = 1 - ((FPR + FNR) / 2);                                                % Accuracy

result.FPR = FPR;
result.FNR = FNR;
result.ACC = ACC;

fprintf('---------------------------------------------------\n');
fprintf('Test\n');
fprintf('FPR: %.2f%%, FNR %.2f%%, ACC: %.2f%%\n', result.FPR * 100, result.FNR * 100, result.ACC * 100);
fprintf('Current time: %s\n', datestr(now, 0));

end

function model = load_model_file(model_file_path)
model_file = load(model_file_path);
models = model_file.model;
model_num = length(models);
accuracy = zeros(1, model_num);

for i=1:model_num
    accuracy(i) = models(i).ACC;
end

max_accuracyt_index = find(accuracy == max(accuracy));
model = models(max_accuracyt_index).svm_model;                              %#ok<FNDSB>
end