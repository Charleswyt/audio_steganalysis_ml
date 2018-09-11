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
%   usage of diff:
%       Y = diff(X, n, dim)
%       X   - input matrix
%       n   - order
%       dim - 1: inter frame, 2: intra frame
%
%   'dif1_h'            1st order difference in horizontal direction             Qi,j - Qi,j+1
%   'dif1_v'            1st order difference in vertical direction               Qi,j - Qi+1,j
%   'dif2_h'            2nd order difference in horizontal direction             Qi,j - 2 * Qi,j+1 + Qi,j+2
%   'dif2_v'            2nd order difference in vertical direction               Qi,j - 2 * Qi+1,j + Qi+2,j
%   'abs'               absolute                                                |Qi,j|
%   'abs_dif1_h'        1st order absolute difference in horizontal direction   |Qi,j| - |Qi,j+1|
%   'abs_dif1_v'        1st order absolute difference in vertical direction     |Qi,j| - |Qi+1,j|
%   'abs_dif2_h'        2nd order absolute difference in horizontal direction   |Qi,j| - 2 * |Qi,j+1| + |Qi,j+2|
%   'abs_dif2_v'        2nd order absolute difference in vertical direction     |Qi,j| - 2 * |Qi+1,j| + |Qi+2,j|
%   'interval_row'      interval subtraction with stride 2 in row direction
%   'interval_col'      interval subtraction with stride 2 in col direction
%   'kv'                imfilter with kv kernel
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
    
elseif strcmp(method, 'interval_col') == 1
    new_matrix = interval_subtraction_col(matrix);
elseif strcmp(method, 'interval_row') == 1
    new_matrix = interval_subtraction_row(matrix);

elseif strcmp(method, 'kv') == 1
    new_matrix = kv_process(matrix);

else
    new_matrix = matrix;
end

end

% - Variable:
% ------------------------------------------input
% matrix                matrix
% -----------------------------------------output
% new_matrix            the processed matrix
function new_matrix = interval_subtraction_col(matrix)

width = size(matrix, 2);
for i = 1:width - 2
    new_matrix(:,i) = matrix(:, i + 2) - matrix(:, i);                      %#ok<AGROW>
end

end

% - Variable:
% ------------------------------------------input
% matrix                matrix
% -----------------------------------------output
% new_matrix            the processed matrix
function new_matrix = interval_subtraction_row(matrix)

height = size(matrix, 1);
for i = 1:height - 2
    new_matrix(i,:) = matrix(i + 2, :) - matrix(i, :);                      %#ok<AGROW>
end

end

% - Variable:
% ------------------------------------------input
% matrix                matrix
% -----------------------------------------output
% new_matrix            the processed matrix
function new_matrix = kv_process(matrix)
    
kv_kernel = [-1,2,-2,2,-1; 2,-6,8,-6,2; -2,8,-12,8,-2; 2,-6,8,-6,2; -1, 2, -2, 2, -1];
new_matrix = imfilter(matrix, kv_kernel);

end