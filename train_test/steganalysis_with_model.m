%% steganalysis with prior
% - result = steganalysis_with_model(audio_file_path, stego_method, feature_type, classifier_type)
% - Variable:
% ------------------------------------------input
% audio_file_path       the path of audio file
% stego_method          the algorithm of audio steganalysis
% feature_type          type of features for classification
% classifier_type       type of classifier for classification
% -----------------------------------------output
% result                result of prediction
% prob                  probability of prediction

% Note: model_file_name: {stego_method}_{feature_type}_{bitrate}.mat, e.g. EECS_jin_128.mat

function [result, prob] = steganalysis_with_model(audio_file_path, stego_method, feature_type, classifier_type)

if ~exist('feature_type', 'var') || isempty(feature_type)
    feature_type = 'JPBC';
end

if ~exist('classifier_type', 'var') || isempty(classifier_type)
    classifier_type = 'svm';
end

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
    model = model_load(model_file_path);
    
    if model == 0
        fprintf('Model load failed.\n');
    else
        % feature type: ADOPT(Jin), MDI2(Ren), JPBC(Wang-IS), I2C(Wang-CIHW), D2MA(Qiao), Occurance(Yan)
        feature = feature_extraction_batch(QMDCT, feature_type);
        
        % svm predict
        if strcmp(classifier_type, 'svm')
            [predict, ~, prop_estimate] = svmpredict(0, feature', model, '-b 1');
        elseif strcmp(classifier_type, 'ensemble_classifier')
            results = ensemble_testing(feature',trained_ensemble);
            predict = results.predictions;
            prob = results.votes;
        else
            predict = 0;
        end
        % show the result
        if predict == -1            % this label can be changed arbitrarily according to training model setting
            prob = prop_estimate(0);
            result = 'cover';
            fprintf('result_%s: cover, probability: %.2f%%\n\n', feature_type, prob*100);
        elseif predict == 1
            prob = prop_estimate(1);
            result = 'stego';
            fprintf('result_%s: stego, probability: %.2f%%\n\n', feature_type, prob*100);
        else
            fprintf('Wrong classifier selection.\n');
        end
    end
else
    fprintf('The current audio file does not exist.\n');
end