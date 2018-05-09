%% Calculate accumulative neighboring joint density with threshold T (A1 -> A2)
% - F = getNAJD(A1,A2,T)
% - Variable:
% ------------------------------------------input
% A1                	matrix A1
% A2                	matrix A2
% -----------------------------------------output
% F                    	accumulative neighboring joint density in vector

function F = getNAJD(A1,A2,T)
% get accumulative neighboring joint density A1 --> A2, range -T..T
F = zeros(2*T+1);
[Nr, Nc] = size(A1);
dn = max(hist(A1(:),-T:T),1); % normalization factors
for i=-T:T
    FF = A2(A1==i); % filtered version
    for j=-T:T
        F(i+T+1,j+T+1) = nnz(FF==j)/(Nr * Nc);
    end
end
F = F(:);
