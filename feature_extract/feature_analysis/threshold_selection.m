%% selection of thereshold value

% - features = threshold_selection(matrix, T)
% - Variable:
% ------------------------------------------input
% matrix                QMDCT matrix
% T                     threshold value
% -----------------------------------------output
% feature               feature vector
% Note:
%   'dif1_h'            1st order difference in horizontal direction
%   'dif1_v'            1st order difference in vertical direction
%   'dif2_h'            2nd order difference in horizontal direction
%   'dif2_v'            2nd order difference in vertical direction

%   'abs_dif1_h'        1st order absolute difference in horizontal direction
%   'abs_dif1_v'        1st order absolute difference in vertical direction
%   'abs_dif2_h'        2nd order absolute difference in horizontal direction
%   'abs_dif2_v'        2nd order absolute difference in vertical direction

function features = threshold_selection(matrix, T)

% preprocessing of QMDCT matrix
matrix_dif_c_1 = pre_process_matrix(matrix, 'dif1_h');
matrix_dif_r_1 = pre_process_matrix(matrix, 'dif1_v');
matrix_dif_c_2 = pre_process_matrix(matrix, 'dif2_h');
matrix_dif_r_2 = pre_process_matrix(matrix, 'dif2_v');

matrix_abs_dif_c_1 = pre_process_matrix(matrix, 'abs_dif1_h');
matrix_abs_dif_r_1 = pre_process_matrix(matrix, 'abs_dif1_v');
matrix_abs_dif_c_2 = pre_process_matrix(matrix, 'abs_dif2_h');
matrix_abs_dif_r_2 = pre_process_matrix(matrix, 'abs_dif2_v');

% feature extraction
feature1 = get_point_block_markov(matrix, T);

feature2 = get_point_block_markov(matrix_dif_c_1, T);
feature3 = get_point_block_markov(matrix_dif_r_1, T);
feature4 = get_point_block_markov(matrix_dif_c_2, T);
feature5 = get_point_block_markov(matrix_dif_r_2, T);

feature6 = get_point_block_markov(matrix_abs_dif_c_1, T);
feature7 = get_point_block_markov(matrix_abs_dif_r_1, T);
feature8 = get_point_block_markov(matrix_abs_dif_c_2, T);
feature9 = get_point_block_markov(matrix_abs_dif_r_2, T);

% feature merging
features = [feature1;feature2;feature3;feature4;feature5;feature6;feature7;feature8;feature9];

% eliminate the column in which all elements are zero value
features(:, all(features==0, 1)) = [];

end