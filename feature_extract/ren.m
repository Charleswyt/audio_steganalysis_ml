%% Ren-NAJD
% - features = ren(matrix, T)
% - Variable:
% ------------------------------------------input
% matrix                QMDCT matrix (QMDCT系数矩阵, 4*N*L, N为音频帧总数, L为每声道内QMDCT系数个数)
% T                     threshold value (截断阈值T)
% -----------------------------------------output
% feature               feature vector (特征向量)

function features = ren(matrix, T)

%% the prr-processing of QMDCT matrix
matrix_intra_dif1 = pre_process_matrix(matrix, 'dif1_h');                   % 1st col difference (一阶列差分矩阵 M(r, c + 1) - M(r, c))
matrix_inter_dif1 = pre_process_matrix(matrix, 'dif1_v');                   % 1st row difference (阶行差分矩阵 M(r + 1, c) - M(r, c))
matrix_intra_dif2 = pre_process_matrix(matrix, 'dif2_h');                   % 2nd col difference ( 二阶列差分矩阵 M(r, c) + M(r, c + 2) - 2 * M(r, c + 1))
matrix_inter_dif2 = pre_process_matrix(matrix, 'dif2_v');                   % 2nd row difference (二阶行差分矩阵 M(r, c) + M(r + 2, c) - 2 * M(r + 1, c))

%% feature wxtraction, transition probability matrix (特征提取(Markov转移概率, 行列方向))
featrue1 = get_markov(matrix_intra_dif1, 'hv', T, 1);
featrue2 = get_markov(matrix_inter_dif1, 'hv', T, 1);
featrue3 = get_markov(matrix_intra_dif2, 'hv', T, 1);
featrue4 = get_markov(matrix_inter_dif2, 'hv', T, 1);

%% feature wxtraction, accumulative neighboring joint density (特征提取(邻域累积联合密度, 行列方向))
featrue5 = get_NAJD(matrix_intra_dif1, 'hv', T, 1);
featrue6 = get_NAJD(matrix_inter_dif1, 'hv', T, 1);
featrue7 = get_NAJD(matrix_intra_dif2, 'hv', T, 1);
featrue8 = get_NAJD(matrix_inter_dif2, 'hv', T, 1);

features = [featrue1;featrue2;featrue3;featrue4;featrue5;featrue6;featrue7;featrue8];
