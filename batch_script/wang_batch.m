%% wang feature extraction in batch
% 算法说明：
%     计算QMDCT、AQMDCT系数矩阵水平、竖直方向的Markov转移概率与2*2分块Markov转移概率
%
% - Variable:
% ------------------------------------------input
% matrixs           QMDCT coefficients matrix (QMDCT系数矩阵)
%                       size(matrix) * N, matrix为单个QMDCT系数矩阵, N为样本总数
% T                 threshold value (截断阈值)
% numbers           the number of audio files to be processed (当前处理的样本总数, 需小于N)
% -----------------------------------------output
% features          feature dimension (特征向量(Dim * N, Dim为特征维度, N为样本数))

function features = wang_batch(matrixs, T, numbers)

total_number = size(matrixs, 3);

if ~exist('T', 'var') || isempty(T)
    T = 15;
end

if ~exist('numbers', 'var') || isempty(numbers)
    numbers = total_number;
end

start_time = tic;

feature_dim = 2*2*(2*T+1) + 2*2*(T+1);
features = zeros(numbers, feature_dim);

for i = 1:numbers
    matrix = matrixs(:,:,i);
    features(i,:) = wang(matrix, T);
end

end_time = toc(start_time);

fprintf('Wang feature extraction completes, T = %d, runtime: %.2fs\n', T, end_time);