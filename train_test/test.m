%% test
% - test(audio_file_path, stego_method, feature_type)
% - Variable:
% ------------------------------------------input
% audio_file_path       the path of audio file
% stego_method          the algorithm of audio steganalysis
% percent               the percent of training set, default is 0.8
% n                     the times of cross-validation default is 10
% model_file_name       the file name of model
% is_rewrite            whether to rewrite the model file
% -----------------------------------------output
% result                result
%    FPR                False positive rate
%    FNR                False negative rate
%    ACC                Accuracy
% model                 model
% predict_label         predictal label
% ground_truth          real label
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