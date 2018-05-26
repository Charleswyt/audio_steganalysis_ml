function result = test_batch(cover_feature, stego_feature, model_file_path)

sample_num_cover = size(cover_feature, 1);                                  % the number of cover samples
sample_num_stego = size(stego_feature, 1);                                  % the number of stego samples

cover_label = -ones(sample_num_cover, 1);                                   % cover label
stego_label =  ones(sample_num_stego, 1);                                   % steog label
data = [cover_feature; stego_feature];                                      % data and label pair
label = [cover_label; stego_label];                                         % label

model = load(model_file_path);
predict = svmpredict(label, data, model.model);

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