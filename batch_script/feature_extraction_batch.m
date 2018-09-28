%% features extraction in batch
%
% - features = feature_extraction_batch(matrixs, T)
% - Variable:
% ------------------------------------------input
% matrixs           QMDCT coefficients matrix
%                       size(matrix) * N, N is the total number of samples
% feature_type      type of extracted feature
% option: ADOPT(Jin), MDI2(Ren), JPBC(Wang-IS), I2C(Wang-CIHW), D2MA(Qiao), Occurance(Yan)
% T                 threshold value
% numbers           the number of audio files to be processed
% -----------------------------------------output
% features          features

function features = feature_extraction_batch(matrixs, feature_type, T, numbers)

total_number = size(matrixs, 3);

if ~exist('T', 'var') || isempty(T)
    if strcmp(feature_type, 'ADOTP')
        T = 6;
    elseif strcmp(feature_type, 'MDI2')
        T = 4;
    elseif strcmp(feature_type, 'I2C')
        T = 3;
    elseif strcmp(feature_type, 'JPBC')
        T = 5;
    elseif strcmp(feature_type, 'D2MA')
        T = 4;
    elseif strcmp(feature_type, 'Co-Occurrence')
        T = 15;
    else
        T = 5;
    end
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