%% Qiao features for MP3 steganalysis
% - feature = feature_d2ma(matrix, T)
% - Variable:
% ------------------------------------------input
% matrix                QMDCT matrix
% T                     threshold value
% -----------------------------------------output
% features              feature vector

function features = feature_d2ma(matrix, T)

if ~exist('T', 'var') || isempty(T)
    T = 4;
end

[~, width] = size(matrix);
subband_num = floor(width / 18);

matrix_dif2_v = pre_process_matrix(matrix, 'dif2_v');

% calculate the mean value, standard deviation, skewness, and kurtosis of subband signals
init = zeros(subband_num, 1);
[mean_value, std_value, skew_value, kurt_value] = deal(init, init, init, init);

for index = 1:subband_num
    % abtain the MDCT_B
    matrix_subband = matrix_dif2_v(:, (index-1)*18+1:index*18);
    
    % calculate statistics
    mean_value(index) = mean(mean(matrix_subband));
    std_value(index) = std(std(matrix_subband));
    skew_value(index) = skewness(skewness(matrix_subband));
    kurt_value(index) = kurtosis(kurtosis(matrix_subband));
end

% calculate accumulative neighboring joint density and Markov approach
feature_markov = get_markov(matrix_dif2_v, 'v', T);
feature_NAJD = get_NAJD(matrix_dif2_v, 'v', T);

features = [mean_value; std_value; skew_value; kurt_value; feature_markov; feature_NAJD];

end

