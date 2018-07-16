%% Ren-NAJD
% - features = feature_ren(matrix, T)
% - Variable:
% ------------------------------------------input
% matrix                QMDCT matrix
% T                     threshold value
% -----------------------------------------output
% feature               feature vector

function features = feature_ren(matrix, T)

%% the prr-processing of QMDCT matrix
matrix_intra_dif1 = pre_process_matrix(matrix, 'dif1_h');                   % 1st col difference, M(r, c + 1) - M(r, c)
matrix_inter_dif1 = pre_process_matrix(matrix, 'dif1_v');                   % 1st row difference, M(r + 1, c) - M(r, c)
matrix_intra_dif2 = pre_process_matrix(matrix, 'dif2_h');                   % 2nd col difference, M(r, c) + M(r, c + 2) - 2 * M(r, c + 1)
matrix_inter_dif2 = pre_process_matrix(matrix, 'dif2_v');                   % 2nd row difference, M(r, c) + M(r + 2, c) - 2 * M(r + 1, c)

%% feature wxtraction, transition probability matrix
featrue1 = get_markov(matrix_intra_dif1, 'hv', T, 1);
featrue2 = get_markov(matrix_inter_dif1, 'hv', T, 1);
featrue3 = get_markov(matrix_intra_dif2, 'hv', T, 1);
featrue4 = get_markov(matrix_inter_dif2, 'hv', T, 1);

%% feature wxtraction, accumulative neighboring joint density
featrue5 = get_NAJD(matrix_intra_dif1, 'hv', T, 1);
featrue6 = get_NAJD(matrix_inter_dif1, 'hv', T, 1);
featrue7 = get_NAJD(matrix_intra_dif2, 'hv', T, 1);
featrue8 = get_NAJD(matrix_inter_dif2, 'hv', T, 1);

features = [featrue1;featrue2;featrue3;featrue4;featrue5;featrue6;featrue7;featrue8];
