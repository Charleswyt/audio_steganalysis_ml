%% Extract blocking accumulative neighboring joint density feature
% - feature = get_block_markov(matrix, directions, block_size, T, order)
% - Variable:
% ------------------------------------------input
% matrix            input data
% directions        calculation direction
%
%   'h'   - horizontal | intra-frame
%   'v'   - vertical   | inter-frame
%   'd'   - diagonal
%   'm'   - minor diagonal
%   'hv'  - horizontal and vertical
%   'dm'  - diagonal and minor diagonal
%   'all' - all direction
%
% T                 threshold value
% order             the orcer of Markov feature
% -----------------------------------------output
% feature           the extracted feature vector

function F = get_block_NAJD(matrix, directions, block_size, T, order)

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

F = zeros(n*(2*T+1)^2,1);                                                   % inter-block part
MODE = block_size^2;                

for mode = 1:MODE
    AA = block_sampling(matrix, mode, MODE);
    feature = get_NAJD(AA, directions, T, order);
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