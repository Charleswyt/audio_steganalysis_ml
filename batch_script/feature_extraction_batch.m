%% features extraction in batch
%
% - features = feature_extraction_batch(matrixs, T)
% - Variable:
% ------------------------------------------input
% matrixs           QMDCT coefficients matrix
%                       size(matrix) * N, N is the total number of samples
% feature_type      type of extracted feature
% T                 threshold value
% numbers           the number of audio files to be processed
% -----------------------------------------output
% features          features

function features = feature_extraction_batch(matrixs, feature_type, T, numbers)

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
    features(i,:) = feature_extraction(matrix, feature_type, T);            %#ok<AGROW>
end

end_time = toc(start_time);

fprintf('%s feature extraction completes, T = %d, runtime: %.2fs\n', feature_type, T, end_time);