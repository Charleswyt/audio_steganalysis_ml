%% Jin-Markov
% - features = jin(matrix, T)
% - Variable:
% ------------------------------------------input
% matrix                QMDCT matrix (QMDCT系数矩阵, 4*N*L, N为音频帧总数, L为每声道内QMDCT系数个数)
% T                     threshold value (截断阈值T)
% -----------------------------------------output
% feature               feature vector (特征向量)

function features = jin(matrix, T)

matrix_abs_dif1 = pre_process_matrix(matrix, 'abs_dif1_v');
feature_abs_dif = get_markov(matrix_abs_dif1, 'hv', T, 1);
features = feature_abs_dif;