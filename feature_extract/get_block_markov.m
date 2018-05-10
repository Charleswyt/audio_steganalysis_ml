%% 块间Markov特征
% - feature = get_block_markov(matrix, directions, block_size, T, order)
% - 变量说明：
% ------------------------------------------input
% matrix            待处理矩阵
% directions        计算方向
%
%   'h' - 水平方向 | 'v' - 竖直方向 | 'd' - 对角线方向 | 'm' - 副对角线方向
%   'hv' - 水平竖直方向 | 'dm' - 对角线方向 | 'all' - 所有方向
%
% block_size        分块大小
% T                 截断阈值
% order             阶数
% -----------------------------------------output
% feature           马尔可夫特征

function F = get_block_markov(matrix, directions, block_size, T, order)

%% 根据计算方向确定特征维度
if strcmp(directions, 'all') == 1
    n = 4;
elseif strcmp(directions, 'hv') == 1 || strcmp(directions, 'dm') == 1
    n = 2;
elseif strcmp(directions, 'h') == 1 || strcmp(directions, 'v') == 1 ...
        || strcmp(directions, 'd') == 1 || strcmp(directions, 'm') == 1
    n = 1;
else
    n = 0;
end

% F = zeros(n*(2*T+1));
F = zeros(n*(2*T+1)^2,1);                                                   % inter-block part
MODE = block_size^2;                

for mode = 1:MODE
    AA = block_sampling(matrix, mode, MODE);
    feature = get_markov(AA, directions, T, order);
    F = F + feature;
end
F = F/MODE;                                                                 % take average over all modes
end

function Mat = block_sampling(matrix, mode, MODE)
step = sqrt(MODE);
mask = reshape(1:MODE, step, step);
[i,j] = find(mask==mode);
Mat = matrix(i:step:end,j:step:end);
end