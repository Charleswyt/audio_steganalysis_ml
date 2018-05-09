%% Wang-Markov (块内块间Markov特征)
% - features = ren(matrix, T)
% - Variable:
% ------------------------------------------input
% matrix                QMDCT matrix (QMDCT系数矩阵, 4*N*L, N为音频帧总数, L为每声道内QMDCT系数个数)
% T                     threshold value (截断阈值T)
% -----------------------------------------output
% feature               feature vector (特征向量)

function features = wang(matrix, T)

matrix_abs = pre_process_matrix(matrix, 'abs');

feature1 = get_markov(matrix, 'hv', T, 1);
feature2 = get_markov(matrix_abs, 'hv', T, 1);
feature3 = get_block_markov(matrix, 'hv', 2, T, 1);
feature4 = get_block_markov(matrix_abs, 'hv', 2, T, 1);

features = [feature1;feature2;feature3;feature4];