% - features = get_point_block_markov(matrix, T)
% - Variable:
% ------------------------------------------input
% matrix                QMDCT matrix
% T                     threshold value
% -----------------------------------------output
% features              feature vector

function features = get_point_block_markov(matrix, T)

feature1 = get_markov(matrix, 'h', T, 1);                                  % point-wise correlation
feature2 = get_markov(matrix, 'v', T, 1);                                  % point-wise correlation

feature3 = get_block_markov(matrix, 'h', 2, T, 1);                         % 2 x 2 block-wise correlation
feature4 = get_block_markov(matrix, 'v', 2, T, 1);                         % 2 x 2 block-wise correlation

feature5 = get_block_markov(matrix, 'h', 4, T, 1);                         % 4 x 4 block-wise correlation
feature6 = get_block_markov(matrix, 'v', 4, T, 1);                         % 4 x 4 block-wise correlation

features = [feature1;feature2;feature3;feature4;feature5;feature6];

end