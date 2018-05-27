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