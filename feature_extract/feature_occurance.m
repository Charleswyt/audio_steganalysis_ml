%% Yan-Concurrence for MP3 steganalysis
% - feature = feature_occurance(matrix, T)
% - Variable:
% ------------------------------------------input
% matrix                QMDCT matrix
% T                     threshold value
% -----------------------------------------output
% features              feature vector

function features = feature_occurance(matrix, T)

if ~exist('T', 'var') || isempty(T)
    T = 15;
end

concurrence_matrix_0 = get_concurrence(matrix, T, 0);
concurrence_matrix_45 = get_concurrence(matrix, T, 45);
concurrence_matrix_90 = get_concurrence(matrix, T, 90);
concurrence_matrix_135 = get_concurrence(matrix, T, 135);

features1 = get_concurrence_features(concurrence_matrix_0);
features2 = get_concurrence_features(concurrence_matrix_45);
features3 = get_concurrence_features(concurrence_matrix_90);
features4 = get_concurrence_features(concurrence_matrix_135);

features = [features1;features2;features3;features4];

end