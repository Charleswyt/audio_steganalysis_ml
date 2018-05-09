%% the preprocessing of matrix
% - new_matrix = pre_process_matrix(matrix, method)
% - Variable:
% ------------------------------------------input
% matrix                matrix
% method                the method of preporcessing
%
%   'dif1_h'            1st order difference in horizontal direction
%   'dif1_v'            1st order difference in vertical direction
%   'dif2_h'            2nd order difference in horizontal direction
%   'dif2_v'            2nd order difference in vertical direction
%   'abs'               absolute
%   'abs_dif1_h'        1st order absolute difference in horizontal direction
%   'abs_dif1_v'        1st order absolute difference in vertical direction
%   'abs_dif2_h'        2nd order absolute difference in horizontal direction
%   'abs_dif2_v'        2nd order absolute difference in vertical direction
% -----------------------------------------output
% new_matrix            the processed matrix (处理后的矩阵)

function new_matrix = pre_process_matrix(matrix, method)

if strcmp(method, 'dif1_h') == 1
    new_matrix = diff(matrix, 1, 2);

elseif strcmp(method, 'dif1_v') == 1
    new_matrix = diff(matrix, 1, 1);

elseif strcmp(method, 'dif2_h') == 1
    new_matrix = diff(matrix, 2, 2);

elseif strcmp(method, 'dif2_v') == 1
    new_matrix = diff(matrix, 2, 1);

elseif strcmp(method, 'abs') == 1
    new_matrix = abs(matrix);

elseif strcmp(method, 'abs_dif1_h') == 1
    matrix = abs(matrix);
    new_matrix = diff(matrix, 1, 2);

elseif strcmp(method, 'abs_dif1_v') == 1
    matrix = abs(matrix);
    new_matrix = diff(matrix, 1, 1);

elseif strcmp(method, 'abs_dif2_h') == 1
    matrix = abs(matrix);
    new_matrix = diff(matrix, 2, 2);

elseif strcmp(method, 'abs_dif2_v') == 1
    matrix = abs(matrix);
    new_matrix = diff(matrix, 2, 1);
else
    new_matrix = matrix;
end