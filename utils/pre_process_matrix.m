%% the preprocessing of matrix
% - new_matrix = pre_process_matrix(matrix, method)
% - Variable:
% ------------------------------------------input
% matrix                matrix
% method                the method of preporcessing
%
% Suppose, matrix M = [
%                       Q1,1 Q1,2 ... Q1,576
%                              ...
%                       Qi,1 Qi,2 ... Qi,576
%                              ...
%                       Q200,1 Q200,2 ... Q200,576
%                                                  ]
%   'dif1_h'            1st order difference in horizontal direction             Qi,j - Qi,j+1
%   'dif1_v'            1st order difference in vertical direction               Qi,j - Qi+1,j
%   'dif2_h'            2nd order difference in horizontal direction             Qi,j - 2 * Qi,j+1 + Qi,j+2
%   'dif2_v'            2nd order difference in vertical direction               Qi,j - 2 * Qi+1,j + Qi+2,j
%   'abs'               absolute                                                |Qi,j|
%   'abs_dif1_h'        1st order absolute difference in horizontal direction   |Qi,j| - |Qi,j+1|
%   'abs_dif1_v'        1st order absolute difference in vertical direction     |Qi,j| - |Qi+1,j|
%   'abs_dif2_h'        2nd order absolute difference in horizontal direction   |Qi,j| - 2 * |Qi,j+1| + |Qi,j+2|
%   'abs_dif2_v'        2nd order absolute difference in vertical direction     |Qi,j| - 2 * |Qi+1,j| + |Qi+2,j|
%   'interval'          interval subtraction with stride 2
% -----------------------------------------output
% new_matrix            the processed matrix

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
    
elseif strcmp(method, 'interval') == 1
    new_matrix = interval_subtraction(matrix);
else
    new_matrix = matrix;
end

function new_matrix = interval_subtraction(matrix)
% - Variable:
% ------------------------------------------input
% matrix                matrix
% -----------------------------------------output
% new_matrix            the processed matrix

width = size(matrix, 2);
for i = 1:width - 2
    new_matrix(:,i) = matrix(:, i + 2) - matrix(:, i);                      %#ok<AGROW>
end