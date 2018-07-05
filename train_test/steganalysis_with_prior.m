%% steganalysis with prior
% - result = steganalysis_with_prior(audio_file_path, stego_method, feature_type)
% - Variable:
% ------------------------------------------input
% audio_file_path       the path of audio file
% stego_method          the algorithm of audio steganalysis
% percent               the percent of training set, default is 0.8
% n                     the times of cross-validation default is 10
% model_file_name       the file name of model
% is_rewrite            whether to rewrite the model file
% -----------------------------------------output
% result                result of prediction
% prob                  probability of 
% predict_label         predictal label
% ground_truth          real label
% Note: model_file_name: {stego_method}_{feature_type}_{bitrate}.mat, e.g. EECS_jin_128.mat

function [result, prob] = steganalysis_with_prior(audio_file_path, stego_method, feature_type)

% load audio file
audio_info = audioinfo(audio_file_path);
bitrate = audio_info.BitRate;

if exist(audio_file_path, 'file')
    % extract QMDCT coefficients matrix
    QMDCT = get_qmdcts(audio_file_path);
    
    % get model name according to stego method, feature type and bitrate (bitrate can be obtained via code)
    model_file_name = strcat(stego_method, '_', feature_type, '_', num2str(bitrate), '.mat');
    model_file_path = fullfile('.\models', stego_method, model_file_name);
    
    % load model file
    model_file = load(model_file_path);
    model = model_file.model;
    
    % feature extraction (three kinds of feature are available now, jin, ren, wang)
    if strcmp(feature_type, 'jin')
        feature = jin(QMDCT, 6);
    elseif strcmp(feature_type, 'ren')
        feature = ren(QMDCT, 4);
    elseif strcmp(feature_type, 'wang')
        feature = wang(QMDCT, 3);
    end
    
    % svm predict
    [predict, ~, prop_estimate] = svmpredict(0, feature', model, '-b 1');
    
    % show the result
    if predict == -1            % this label can be changed arbitrarily according to training model setting
        prob = prop_estimate(0);
        result = 'cover';
        fprintf('result_%s: cover, probability: %.2f%%\n', feature_type, prob*100);
    else
        prob = prop_estimate(1);
        result = 'stego';
        fprintf('result_%s: stego, probability: %.2f%%\n\n', feature_type, prob*100);
    end
else
    fprintf('The current audio file does not exist.\n');
end