%% calculate distance of two vectors
% - distance = get_vector_distance(vector1, vector2, distance_type, precision, order)
% - Variables:
% ------------------------------------------input
% vector1           vector1
% vector2           vector2
% distance_type     type of distance for calculation
% precision         precision of output
% order             order of Minkowski distance
% -----------------------------------------output
% distance          the calculated distance
% Note: the follwing distance can be calculated
% Euclidean - 1  Manhattan - 2  Chebyshev - 3  Minkowski - 4
% Std_Euclidean - 5  Cosine - 6  Pearson - 7  Hamming - 8  Jaccard - 9
% Bray_Curtis - 10

function distance = get_vector_distance(vector1, vector2, distance_type, precision, order)

% default parameters
if ~exist('distance_type', 'var') || isempty(distance_type)
    distance_type = 'Euclidean';
end

if ~exist('precision', 'var') || isempty(precision)
    precision = 3;
end

if ~exist('order', 'var') || isempty(order)
    order = 3;
end

% distance calculation
if strcmp(distance_type, 'Euclidean') || distance_type == 1
    distance = sqrt(sum((vector1 - vector2).^2));
elseif strcmp(distance_type, 'Manhattan') || distance_type == 2
    distance = sum(abs(vector1 - vector2));
elseif strcmp(distance_type, 'Chebyshev') || distance_type == 3
    distance = max(abs(vector1 - vector2));
elseif strcmp(distance_type, 'Minkowski') || distance_type == 4
    distance = power(sum(power((abs(vector1 - vector2)), order)), 1/order);
elseif strcmp(distance_type, 'Std_Euclidean') || distance_type == 5
    mean_vector1 = mean(vector1);mean_vector2 = mean(vector2);
    std_vector1 = std(vector1);std_vector2 = std(vector2);
    vector1_norm = (vector1 - mean_vector1) / std_vector1;
    vector2_norm = (vector2 - mean_vector2) / std_vector2;
    distance = sqrt(sum((vector1_norm - vector2_norm).^2));
elseif strcmp(distance_type, 'Cosine') || distance_type == 6
    distance = sum(vector1 .* vector2) / sum(vector1.^2) / sum(vector2.^2);
elseif strcmp(distance_type, 'Pearson') || distance_type == 7
    mean_vector1 = mean(vector1);mean_vector2 = mean(vector2);
    vector1_new = vector1 - mean_vector1;
    vector2_new = vector2 - mean_vector2;
    distance = sum(vector1_new .* vector2_new) / sum(vector1_new.^2) / sum(vector2_new.^2);
elseif strcmp(distance_type, 'Hamming') || distance_type == 8
    if isempty(rem(vector1, 1)) ~= 0 || isempty(rem(vector2, 1)) ~= 0
        distance = -1;
    else
        distance = length(find(vector1 - vector2 ~= 0));
    end
elseif strcmp(distance_type, 'Jaccard') || distance_type == 9
    distance = (length(union(vector1, vector2)) - length(intersect(vector1, vector2))) / length(union(vector1, vector2));
elseif strcmp(distance_type, 'Bray_Curtis') || distance_type == 10
    distance = sum(abs(vector1 - vector2)) / (sum(vector1) + sum(vector2));
else
    distance = -1;
end

% round
distance = roundn(distance, -precision);

end