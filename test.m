%% test (测试)
% - test(audio_file_path, stego_method, feature_type)
% - Variable：
% ------------------------------------------input
% audio_file_path       the path of audio file (待检测音频文件的路径)
% stego_method          the algorithm of audio steganalysis (音频隐写分析算法)
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
function result = test(audio_file_path, stego_method, feature_type)

audio_info = audioinfo(audio_file_path);
bitrate = audio_info.BitRate;

if exist(audio_file_path, 'file')
    QMDCT = get_qmdcts(audio_file_path);
    model_file_name = strcat(stego_method, '_', feature_type, '_', num2str(bitrate), '.mat');
    model_file_path = fullfile('.\models', stego_method, model_file_name);

    model = load(model_file_path);
    
    if strcmp(feature_type, 'jin')
        feature = jin(QMDCT, 6);
    elseif strcmp(feature_type, 'ren')
        feature = ren(QMDCT, 4);
    end
    result = svmpredict(0, feature', model.model);
    if result == -1
        fprintf('result_%s: cover\n', feature_type);
    else
        fprintf('result_%s: stego\n', feature_type);
    end
else
    fprintf('The current audio file does not exist.\n');
end