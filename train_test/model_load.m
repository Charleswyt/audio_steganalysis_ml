%% load model
% - model = model_load(model_file_path, classifier_type)
% - Variable:
%------------------------------------------input
% model_file_path       path of model file
% classifier_type       type of classifier
%-----------------------------------------output
% model                 model data
%   if loaded successfully, return the model data
%   if loaded unsuccessfully, return -1

function model = model_load(model_file_path, classifier_type)

model_file = load(model_file_path);
if strcmp(classifier_type, 'svm')
    model = model_file.svm_model;
elseif strcmp(classifier_type, 'ensemble_classifier')
    model = model_file.trained_ensemble;
else
    model = -1;
end

end