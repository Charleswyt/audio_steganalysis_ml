%% calculate concurrence of QMDCT matrix
% - concurence_matrix = get_concurrence(matrix, T, direction)
% - Variables:
% ------------------------------------------input
% matrix            input matrix
% T                 truncated threshold
% direction         dircetion of calculation, option:0, 45, 90, 135
% level             level of calculation
% -----------------------------------------output
% concurence_matrix concurrence matrix

function concurence_matrix = get_concurrence(matrix, T, direction, order, level)

% default parameters
if ~exist('T', 'var') || isempty(T)
    T = 15;
end

if ~exist('direction', 'var') || isempty(direction)
    direction = 0;
end

if ~exist('order', 'var') || isempty(order)
    order = 1;
end

if ~exist('level', 'var') || isempty(level)
    level = 2*T+1;
end

% truncation
Ad = max(min(matrix,T),-T);                                                 % truncate to [-T,T]

% pre-processing
minimum = min(Ad(:));
maximum = max(Ad(:));
Ad = Ad - minimum + 1;
gap = maximum - minimum + 1;
if level > gap
    level = gap;
end
    

% get offset according to direction
directions = [0, 45, 90, 135];
offsets = [0, order;order,order;order,0;order, -order];
offset = zeros(1, 2);
index = find(directions == direction);
if isempty(index)
    [offset(1), offset(2)] = deal(0, order);
else
    [offset(1), offset(2)] = deal(offsets(index, 1), offsets(index, 2));
end

% concurrence matrix calculation
[height, width] = size(Ad);
concurence_matrix = zeros(level);

if direction ~= 135
    for h = 1:height-offset(1)
        for w = 1:width-offset(2)
            concurence_matrix(Ad(h, w), Ad(h + offset(1), w + offset(2))) = ...
                concurence_matrix(Ad(h, w), Ad(h + offset(1), w + offset(2))) + 1;
        end
    end
else
    for h = 1:height-offset(1)
        for w = 1-offset(2):width
            concurence_matrix(Ad(h, w), Ad(h + offset(1), w + offset(2))) = ...
                concurence_matrix(Ad(h, w), Ad(h + offset(1), w + offset(2))) + 1;
        end
    end
end

end