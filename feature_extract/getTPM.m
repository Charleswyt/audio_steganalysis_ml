%% 计算转移概率矩阵A1 -> A2, 截断阈值为T
% - F = getTPM(A1,A2,T)
% - 变量说明：
% ------------------------------------------input
% A1                	转移前的矩阵A1
% A2                	转移后的矩阵A2
% -----------------------------------------output
% F                     markov特征

function F = getTPM(A1,A2,T)
% get transition probability matrix A1 --> A2, range -T..T
F = zeros(2*T+1);
dn = max(hist(A1(:), -T:T), 1);                                            % normalization factors

for i = -T:T
    FF = A2(A1 == i);                                                      % filtered version
    for j = -T:T
        F(i+T+1, j+T+1) = nnz(FF==j) / dn(i+T+1);
    end
end

F = F(:);