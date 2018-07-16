%% jin features extraction in batch

% - features = feature_jin_batch(matrixs, T)
% - Variable:
% ------------------------------------------input
% matrixs           QMDCT coefficients matrix
%                       size(matrix) * N, N is the total number of samples
% T                 threshold value
% numbers           the number of audio files to be processed
% -----------------------------------------output
% features          feature dimension

function features = feature_jin_batch(matrixs, T, numbers)

total_number = size(matrixs, 3);

if ~exist('T', 'var') || isempty(T)
    T = 6;
end

if ~exist('numbers', 'var') || isempty(numbers)
    numbers = total_number;
end

start_time = tic;

for i = 1:numbers
    matrix = matrixs(:,:,i);
    features(i,:) = jin(matrix, T);                         %#ok<AGROW>
end

end_time = toc(start_time);

fprintf('Jin feature extraction completes, T = %d, runtime: %.2fs\n', T, end_time);