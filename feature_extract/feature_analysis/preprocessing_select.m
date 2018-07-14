%% selection of preprocessing methods
%#ok<*SEPEX>

T = 3;
[max_mean_value, max_var, max_skew, max_kurt] = deal(0,0,0,0);
preprocessing_methods = {'origin', 'dif1_h', 'dif1_v', 'dif2_h', 'dif2_v', 'abs_dif1_h', 'abs_dif1_v', 'abs_dif2_h', 'abs_dif2_v'};

cover = load('E:\Myself\2.database\mtap\txt\cover\128\wav10s_00003.txt');
stego = load('E:\Myself\2.database\mtap\txt\stego\EECS\EECS_W_2_B_128_ER_05\wav10s_00003_stego_128.txt');

for i = 1:length(preprocessing_methods)
    preprocessing_method = preprocessing_methods{i};
    
    [cover_mean_value, cover_var, cover_skew, cover_kurt] = preprocessing(cover, preprocessing_method, T);
    [stego_mean_value, stego_var, stego_skew, stego_kurt] = preprocessing(stego, preprocessing_method, T);
    
    dif_mean_value = cover_mean_value - stego_mean_value;
    dif_var = cover_var - stego_var;
    dif_skew = cover_skew - stego_skew;
    dif_kurt = cover_kurt - stego_kurt;
    
    if abs(dif_mean_value) > max_mean_value max_mean_value = dif_mean_value;end
    if abs(dif_var) > max_var max_var = dif_var;end
    if abs(dif_skew) > max_skew max_skew = dif_skew;end
    if abs(dif_kurt) > max_kurt max_kurt = dif_kurt;end
    
    fprintf('=============================\n');
    fprintf('preprocessing method: %s\n', preprocessing_method);
    fprintf('mean    : %.3f\n', dif_mean_value);
    fprintf('variance: %.3f\n', dif_var);
    fprintf('skewness: %.3f\n', dif_skew);
    fprintf('kurtosis: %.3f\n', dif_kurt);
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