%% ensemeble training
% - [result, trained_ensemble] = training_ensemble(cover_feature, stego_feature, 
%       percent, is_figure, model_file_name, model_files_dir, is_rewrite)
% - Variable:
%------------------------------------------input
% cover_feature         the feature of cover samples
% stego_feature         the feature of stego samples
% percent               the percent of training set, default is 0.8
% model_file_name       the file name of model
% model_files_dir       directory of models
% is_rewrite            whether to rewrite the model file
%-----------------------------------------output
% result                result
%   FPR                 False positive rate
%   FNR                 False negative rate
%   ACC                 Accuracy
% trained_ensemble      Emseble training model

function [result, trained_ensemble] = ...
    training_ensemble(cover_feature, stego_feature, percent, is_figure, model_file_name, model_files_dir, is_rewrite)

%default parameters
if ~exist('percent', 'var') || isempty(percent)
    percent = 0.8;
end

if ~exist('is_figure', 'var') || isempty(is_figure)
    is_figure = 'False';
end

if ~exist('model_file_name', 'var') || isempty(model_file_name)
    model_file_name = strcat(inputname(2), '_ensemeble.mat');
end

if ~exist('model_files_dir', 'var') || isempty(model_files_dir)
    model_files_dir = './models';
end

if ~exist('is_rewrite', 'var') || isempty(is_rewrite)
    is_rewrite = 'False';
end

% model files dir
if ~exist(model_files_dir, 'file')
    mkdir(model_files_dir);
end

% PRNG initialization with seed 1
RandStream.setGlobalStream(RandStream('mt19937ar','Seed',1));

% Division into training/testing set (half/half & preserving pairs)
random_permutation = randperm(size(cover_feature,1));
training_set = random_permutation(1:round(size(cover_feature,1) * percent));
testing_set = random_permutation(round(size(cover_feature,1) * percent)+1:end);

% Prepare training features
TRN_cover = cover_feature(training_set,:);
TRN_stego = stego_feature(training_set,:);

% Prepare testing features
TST_cover = cover_feature(testing_set,:);
TST_stego = stego_feature(testing_set,:);

% Train ensemble with all settings default - automatic search for the
% optimal subspace dimensionality (d_sub), automatic stopping criterion for
% the number of base learners (L), both PRNG seeds (for subspaces and
% bootstrap samples) are initialized randomly.
[trained_ensemble,results] = ensemble_training(TRN_cover,TRN_stego);

% Testing phase - we can conveniently test on cover and stego features separately
test_results_cover = ensemble_testing(TST_cover,trained_ensemble);
test_results_stego = ensemble_testing(TST_stego,trained_ensemble);

% Predictions: -1 stands for cover, +1 for stego
false_alarms = sum(test_results_cover.predictions~=-1);
missed_detections = sum(test_results_stego.predictions~=+1);
true_negative = sum(test_results_cover.predictions==-1);
true_positive = sum(test_results_stego.predictions==1);
num_testing_samples = size(TST_cover,1)+size(TST_stego,1);
testing_error = (false_alarms + missed_detections)/num_testing_samples;
fprintf('Testing error: %.4f\n',testing_error);

%% evaluation
FPR = false_alarms / (false_alarms + true_negative);                        % False Positive Rate
FNR = missed_detections / (true_positive + missed_detections);              % False Negative Rate
ACC = 1 - ((FPR + FNR) / 2);                                                % Accuracy

result.FPR = FPR;
result.FNR = FNR;
result.ACC = ACC;

%% save the model file
model_file_path = fullfile(model_files_dir, model_file_name);

if ~exist(model_file_path, 'file')
    save(model_file_path, 'trained_ensemble');
elseif exist(model_file_path, 'file') && strcmp(is_rewrite, 'True') == 1
    save(model_file_path, 'trained_ensemble');
else
    fprintf('');
end

fprintf('---------------------------------------------------\n');
fprintf('Ensemble training and test: \n');
fprintf('Training set: %d%%, Test set: %d%%\n', percent*100, 100-percent*100);
fprintf('FPR: %.3f%%, FNR %.3f%%, ACC: %.3f%%\n', result.FPR*100, result.FNR*100, result.ACC*100);
fprintf('The model file is saved as "%s"\n', model_file_name);
fprintf('Current time: %s\n', datestr(now, 0));

if strcmp(is_figure, 'True') || strcmp(is_figure, 'rrue')
    % plot the results of the search for optimal subspace dimensionality
    figure(1);
    clf;plot(results.search.d_sub,results.search.OOB,'.b');hold on;
    plot(results.optimal_d_sub,results.optimal_OOB,'or','MarkerSize',8);
    xlabel('Subspace dimensionality');ylabel('OOB error');
    legend({'all attempted dimensions',sprintf('optimal dimension %i',results.optimal_d_sub)});
    title('Search for the optimal subspace dimensionality');

    % plot the OOB progress with the increasing number of base learners (at the
    % optimal value of subspace dimensionality).
    figure(2);
    clf;plot(results.OOB_progress,'.-b');
    xlabel('Number of base learners');ylabel('OOB error')
    title('Progress of the OOB error estimate');

    % We can plot the histogram of cover/stego voting results (from the
    % majority voting of individual base learners).
    figure(3);clf;
    [hc,x] = hist(test_results_cover.votes,50);
    bar(x,hc,'b');hold on;
    [hs,x] = hist(test_results_stego.votes,50);
    bar(x,hs,'r');hold on;
    legend({'cover','stego'});
    xlabel('majority voting');
    ylabel('histogram');

    % ROC curve can be obtain using the following code
    labels = [-ones(size(TST_cover,1),1);ones(size(TST_stego,1),1)];
    votes  = [test_results_cover.votes;test_results_stego.votes];
    [X,Y,~,auc] = perfcurve(labels,votes,1);
    figure(4);clf;plot(X,Y);hold on;plot([0 1],[0 1],':k');
    xlabel('False positive rate'); ylabel('True positive rate');title('ROC');
    legend(sprintf('AUC = %.4f',auc));
end

end