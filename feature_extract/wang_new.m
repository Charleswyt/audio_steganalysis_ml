%% Wang-Markov_multiscale
% - features = wang_new(matrix, T)
% - Variable:
% ------------------------------------------input
% matrix                QMDCT matrix
% T                     threshold value
% -----------------------------------------output
% feature               feature vector

function features = wang_new(matrix, T)

matrix_abs_dif2_h = pre_process_matrix(matrix, 'abs_dif2_h');
matrix_abs_dif2_v = pre_process_matrix(matrix, 'abs_dif2_v');

feature1 = get_point_block_markov(matrix_abs_dif2_h, T);
feature2 = get_point_block_markov(matrix_abs_dif2_v, T);

features = [feature1;feature2];

features(:, all(features==0, 1)) = [];