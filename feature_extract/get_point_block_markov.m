% - features = get_point_block_markov(matrix, T)
% - Variable:
% ------------------------------------------input
% matrix                QMDCT matrix
% T                     threshold value
% -----------------------------------------output
% features              feature vector

function features = get_point_block_markov(matrix, T)

feature1 = get_markov(matrix, 'hv', T, 1);                                  % point-wise correlation
feature2 = get_block_markov(matrix, 'hv', 2, T, 1);                         % 2 x 2 block-wise correlation
feature3 = get_block_markov(matrix, 'hv', 4, T, 1);                         % 4 x 4 block-wise correlation

features = [feature1;feature2;feature3];

end