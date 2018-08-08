%% Yan-Concurrence for MP3 steganalysis
% - feature = feature_yan(matrix, T)
% - Variable:
% ------------------------------------------input
% matrix                QMDCT matrix
% T                     threshold value
% -----------------------------------------output
% feature               feature vector

function feature = feature_yan(matrix, T)

concurrence_matrix_0 = get_concurrence(matrix, T, 0);
concurrence_matrix_45 = get_concurrence(matrix, T, 45);
concurrence_matrix_90 = get_concurrence(matrix, T, 90);
concurrence_matrix_135 = get_concurrence(matrix, T, 135);

feature = [feature1;feature2;feature3;feature4];