%% Jin-Markov
% - features = jin(matrix, T)
% - Variable:
% ------------------------------------------input
% matrix                QMDCT matrix
% T                     threshold value
% -----------------------------------------output
% feature               feature vector

function features = jin(matrix, T)

matrix_dif1 = pre_process_matrix(matrix, 'dif1_v');
matrix_abs_dif1 = pre_process_matrix(matrix, 'abs_dif1_v');

feature = get_markov(matrix, 'hv', T, 1);
feature_dif = get_markov(matrix_dif1, 'hv', T, 1);
feature_abs_dif = get_markov(matrix_abs_dif1, 'hv', T, 1);

features = [feature;feature_dif;feature_abs_dif];