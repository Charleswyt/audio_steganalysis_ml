%% Jin-Markov
% - features = jin(matrix, T)
% - Variable:
% ------------------------------------------input
% matrix                QMDCT matrix
% T                     threshold value
% -----------------------------------------output
% feature               feature vector

function features = jin(matrix, T)

matrix_abs_dif1 = pre_process_matrix(matrix, 'abs_dif1_v');
feature_abs_dif = get_markov(matrix_abs_dif1, 'hv', T, 1);
features = feature_abs_dif;