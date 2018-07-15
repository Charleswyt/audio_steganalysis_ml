%% selection of preprocessing methods
%#ok<*SEPEX>

T = 3;
[max_mean_value, max_var, max_skew, max_kurt] = deal(0,0,0,0);
preprocessing_methods = {'origin', 'dif1_h', 'dif1_v', 'dif2_h', 'dif2_v', 'abs_dif1_h', 'abs_dif1_v', 'abs_dif2_h', 'abs_dif2_v'};

cover = load('E:\Myself\2.database\mtap\txt\cover\128\wav10s_00005.txt');
stego = load('E:\Myself\2.database\mtap\txt\stego\EECS\EECS_W_2_B_128_ER_05\wav10s_00005_stego_128.txt');

for i = 1:length(preprocessing_methods)
    preprocessing_method = preprocessing_methods{i};
    
    [cover_mean_value, cover_var, cover_skew, cover_kurt] = preprocessing(cover, preprocessing_method, T);
    [stego_mean_value, stego_var, stego_skew, stego_kurt] = preprocessing(stego, preprocessing_method, T);
    
    dif_mean_value = cover_mean_value - stego_mean_value;
    dif_var = cover_var - stego_var;
    dif_skew = cover_skew - stego_skew;
    dif_kurt = cover_kurt - stego_kurt;
    
    distance = get_distance(cover, stego, preprocessing_method, T, 'euclidean');
    
    fprintf('=============================\n');
    fprintf('Euclidean Distance : %.3f\n', distance.euclidean_distance);
    fprintf('Cosine Similarity  : %.3f\n', distance.cosine);
    fprintf('Pearson Correlation: %.3f\n', distance.pearson_correlation);
end

fprintf('max mean    : %.5f\n', max_mean_value);
fprintf('max variance: %.5f\n', max_var);
fprintf('max skewness: %.5f\n', max_skew);
fprintf('max kurtosis: %.5f\n', max_kurt);
    
% [mean_value, var, skew, kurt] = preprocessing_select(preprocessing_method)
% - Variable:
% ------------------------------------------input
% matrix                    QMDCT coefficiens matrix
% preprocessing_method      the method of preprocessing
% T                         truncated threshold T
% -----------------------------------------output
% mean_value                mean     of feature vector
% var                       variance of feature vector
% skew                      skewness of feature vector
% kurt                      kurtosis of feature vector

function [mean_value, var, skew, kurt] = preprocessing(matrix, preprocessing_method, T)

if strcmp(preprocessing_method, 'origin') new_matrix = matrix;end

if strcmp(preprocessing_method, 'dif1_h') new_matrix = pre_process_matrix(matrix, 'dif1_h');end
if strcmp(preprocessing_method, 'dif1_v') new_matrix = pre_process_matrix(matrix, 'dif1_v');end
if strcmp(preprocessing_method, 'dif2_h') new_matrix = pre_process_matrix(matrix, 'dif2_h');end
if strcmp(preprocessing_method, 'dif2_v') new_matrix = pre_process_matrix(matrix, 'dif2_v');end

if strcmp(preprocessing_method, 'abs_dif1_h') new_matrix = pre_process_matrix(matrix, 'abs_dif1_h');end
if strcmp(preprocessing_method, 'abs_dif1_v') new_matrix = pre_process_matrix(matrix, 'abs_dif1_v');end
if strcmp(preprocessing_method, 'abs_dif2_h') new_matrix = pre_process_matrix(matrix, 'abs_dif2_h');end
if strcmp(preprocessing_method, 'abs_dif2_v') new_matrix = pre_process_matrix(matrix, 'abs_dif2_v');end

feature = get_point_block_markov(new_matrix, T);

[mean_value, var, skew, kurt] = statistical_characteristics(feature);

end


% function distance = get_distance(vector1, vector2, metric)
% - Variable:
% ------------------------------------------input
% matrix_cover              cover QMDCT coefficients matrix
% matrix_stego              stego QMDCT coefficients matrix
% metric                    metric
% -----------------------------------------output
% distance
%   euclidean               euclidean distance

% Note:
%   methods = {'euclidean'; 'seuclidean'; 'cityblock'; 'chebychev'; ...
%            'mahalanobis'; 'minkowski'; 'cosine'; 'correlation'; ...
%            'spearman'; 'hamming'; 'jaccard';'squaredEuclidean'};

function distance = get_distance(matrix_cover, matrix_stego, preprocessing_method, T, metric)

if strcmp(preprocessing_method, 'origin') new_matrix_cover = matrix_cover;new_matrix_stego = matrix_stego;end

if strcmp(preprocessing_method, 'dif1_h') new_matrix_cover = pre_process_matrix(matrix_cover, 'dif1_h');new_matrix_stego = pre_process_matrix(matrix_stego, 'dif1_h');end
if strcmp(preprocessing_method, 'dif1_v') new_matrix_cover = pre_process_matrix(matrix_cover, 'dif1_v');new_matrix_stego = pre_process_matrix(matrix_stego, 'dif1_h');end
if strcmp(preprocessing_method, 'dif2_h') new_matrix_cover = pre_process_matrix(matrix_cover, 'dif2_h');new_matrix_stego = pre_process_matrix(matrix_stego, 'dif1_h');end
if strcmp(preprocessing_method, 'dif2_v') new_matrix_cover = pre_process_matrix(matrix_cover, 'dif2_v');new_matrix_stego = pre_process_matrix(matrix_stego, 'dif1_h');end

if strcmp(preprocessing_method, 'abs_dif1_h') new_matrix_cover = pre_process_matrix(matrix_cover, 'abs_dif1_h');new_matrix_stego = pre_process_matrix(matrix_stego, 'abs_dif1_h');end
if strcmp(preprocessing_method, 'abs_dif1_v') new_matrix_cover = pre_process_matrix(matrix_cover, 'abs_dif1_v');new_matrix_stego = pre_process_matrix(matrix_stego, 'abs_dif1_h');end
if strcmp(preprocessing_method, 'abs_dif2_h') new_matrix_cover = pre_process_matrix(matrix_cover, 'abs_dif2_h');new_matrix_stego = pre_process_matrix(matrix_stego, 'abs_dif1_h');end
if strcmp(preprocessing_method, 'abs_dif2_v') new_matrix_cover = pre_process_matrix(matrix_cover, 'abs_dif2_v');new_matrix_stego = pre_process_matrix(matrix_stego, 'abs_dif1_h');end

feature_cover = get_point_block_markov(new_matrix_cover, T);
feature_stego = get_point_block_markov(new_matrix_stego, T);

distance.euclidean_distance = sqrt(sum((feature_cover - feature_stego).^2));
numerator = sum(feature_cover.*feature_stego);
denominator = sqrt(sum(feature_cover.^2)) * sqrt(sum(feature_stego.^2));
distance.cosine = numerator / denominator;

feature_cover_new = feature_cover - mean(feature_cover);
feature_stego_new = feature_stego - mean(feature_stego);
numerator = sum(feature_cover_new.*feature_stego_new);
denominator = sqrt(sum(feature_cover_new.^2)) * sqrt(sum(feature_stego_new.^2));
distance.pearson_correlation = numerator / denominator;

end