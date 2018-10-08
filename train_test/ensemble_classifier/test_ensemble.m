%% test via ensemble classifier
% - result = test_ensemble(cover_feature, stego_feature, model_file_path)
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

function result = test_ensemble(cover_feature, stego_feature, model_file_path, is_figure)

if ~exist('is_figure', 'var') || isempty(is_figure)
    is_figure = 'False';
end

trained_ensemble_file = load(model_file_path);
trained_ensemble = trained_ensemble_file.trained_ensemble;

test_results_cover = ensemble_testing(cover_feature,trained_ensemble);
test_results_stego = ensemble_testing(stego_feature,trained_ensemble);

% Predictions: -1 stands for cover, +1 for stego
false_alarms = sum(test_results_cover.predictions~=-1);
missed_detections = sum(test_results_stego.predictions~=+1);
true_negative = sum(test_results_cover.predictions==-1);
true_positive = sum(test_results_stego.predictions==1);
num_testing_samples = size(cover_feature,1)+size(stego_feature,1);
testing_error = (false_alarms + missed_detections)/num_testing_samples;
fprintf('Testing error: %.4f\n',testing_error);

%% evaluation
FPR = false_alarms / (false_alarms + true_negative);                        % False Positive Rate
FNR = missed_detections / (true_positive + missed_detections);              % False Negative Rate
ACC = 1 - ((FPR + FNR) / 2);                                                % Accuracy

result.FPR = FPR;
result.FNR = FNR;
result.ACC = ACC;

fprintf('---------------------------------------------------\n');
fprintf('Test via ensemble classifier.\n');
fprintf('FPR: %.3f%%, FNR %.3f%%, ACC: %.3f%%\n', result.FPR*100, result.FNR*100, result.ACC*100);
fprintf('Current time: %s\n', datestr(now, 0));

if strcmp(is_figure, 'True') || strcmp(is_figure, 'rrue')
    figure(1);clf;
    [hc,x] = hist(test_results_cover.votes,50);
    bar(x,hc,'b');hold on;
    [hs,x] = hist(test_results_stego.votes,50);
    bar(x,hs,'r');hold on;
    legend({'cover','stego'});
    xlabel('majority voting');
    ylabel('histogram');

    % ROC curve can be obtain using the following code
    labels = [-ones(size(cover_feature,1),1);ones(size(stego_feature,1),1)];
    votes  = [test_results_cover.votes;test_results_stego.votes];
    [X,Y,~,auc] = perfcurve(labels,votes,1);
    figure(2);clf;plot(X,Y);hold on;plot([0 1],[0 1],':k');
    xlabel('False positive rate'); ylabel('True positive rate');title('ROC');
    legend(sprintf('AUC = %.4f',auc));
end

end