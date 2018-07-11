%% get the first column in which all elements are zero values
% - start_column = get_zero_column(qmdct_file_path)
% - Variable:
% ------------------------------------------input
% qmdct_file_path       path of qmdct file
% -----------------------------------------output
% start_column          the first column in which all elements are zero values
%
% Note:
% the number of zero values in QMDCT coefficients decreases with the increase of bitrate
%       Bitrate         column
%        128             420~
%        192             430~
%        256             500~
%        320             560~

function start_column = get_zero_column(qmdct_file_path)

matrix = load(qmdct_file_path);                                             % load the matrix
[~, col] = size(matrix);                                                    % get the row and col of the matrix
threshold = 2;                                                              % the number of least zero value

for i = 1:col
    matrix_col = (matrix(:,i)~=0);                                          % judge whether each element is zero or not
    num_zero_values = numel(find(matrix_col)==0);                           % get the number of zero values in each column
    if num_zero_values < threshold
        start_column = i;
        break;
    end
end

end