%% Wang-Markov_multiscale
% - feature = feature_wang(matrix, T)
% - Variable:
% ------------------------------------------input
% matrix                QMDCT matrix
% T                     threshold value
% -----------------------------------------output
% feature               feature vector

function feature = feature_wang(matrix, T)

matrix_dif2_v = pre_process_matrix(matrix, 'dif2_v');
matrix_abs_dif1_v = pre_process_matrix(matrix, 'abs_dif1_v');
matrix_abs_dif2_v = pre_process_matrix(matrix, 'abs_dif2_v');

feature1 = get_point_block_markov(matrix, T);
feature2 = get_point_block_markov(matrix_dif2_v, T);
feature3 = get_point_block_markov(matrix_abs_dif2_v, T);

feature = [feature1;feature2;feature3];