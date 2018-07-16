%% Calculate transition probability matrix with threshold T (A1 -> A2)
% - F = getTPM(A1,A2,T)
% - Variable:
% ------------------------------------------input
% A1                	matrix A1
% A2                	matrix A2
% -----------------------------------------output
% F                     transition probability matrix in vector

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