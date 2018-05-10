%% wang feature extraction in batch
%
% - Variable:
% ------------------------------------------input
% matrixs           QMDCT coefficients matrix
%                       size(matrix) * N, N is the total number of samples
% T                 threshold value
% numbers           the number of audio files to be processed
% -----------------------------------------output
% features          feature dimension

function features = wang_batch(matrixs, T, numbers)

total_number = size(matrixs, 3);

if ~exist('T', 'var') || isempty(T)
    T = 15;
end

if ~exist('numbers', 'var') || isempty(numbers)
    numbers = total_number;
end

start_time = tic;

% feature_dim = 2*2*(2*T+1) + 2*2*(T+1);
% features = zeros(numbers, feature_dim);

for i = 1:numbers
    matrix = matrixs(:,:,i);
    features(i,:) = wang(matrix, T);                %#ok<AGROW>
end

end_time = toc(start_time);

fprintf('Wang feature extraction completes, T = %d, runtime: %.2fs\n', T, end_time);