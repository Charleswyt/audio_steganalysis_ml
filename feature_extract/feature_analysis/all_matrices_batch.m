%% threshold value selection in batch
%
% - features = all_matrices_batch(matrixs, T, number)
% - Variable:
% ------------------------------------------input
% matrixs           QMDCT coefficients matrix
%                       size(matrix) * N, N is the total number of samples
% T                 threshold value
% numbers           the number of audio files to be processed
% -----------------------------------------output
% features          feature dimension

function features = all_matrices_batch(matrixs, T, numbers)

total_number = size(matrixs, 3);

if ~exist('T', 'var') || isempty(T)
    T = 3;
end

if ~exist('numbers', 'var') || isempty(numbers)
    numbers = total_number;
end

start_time = tic;

for i = 1:numbers
    matrix = matrixs(:,:,i);
    features(i,:) = all_matrices(matrix, T);                                %#ok<AGROW>
end

end_time = toc(start_time);