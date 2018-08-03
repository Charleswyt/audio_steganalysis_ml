%% calculate distance of two probalities vectors
% - distance = get_vector_distance(vector1, vector2, distance_type, precision, order)
% - Variables:
% ------------------------------------------input
% vector1           vector1
% vector2           vector2
% distance_type     type of distance for calculation
% precision         precision of output
% -----------------------------------------output
% distance          the calculated distance
% Note: the follwing distance can be calculated
% Chi_Square - 1  Cross_Entropy - 2  Jensen_Shannon - 3
% Hellinger - 4  Bhattacharyya - 5

function distance = get_prob_vector_distance(vector1, vector2, distance_type, precision)

% default parameters
if ~exist('distance_type', 'var') || isempty(distance_type)
    distance_type = 'Cross_Entropy';
end

if ~exist('precision', 'var') || isempty(precision)
    precision = 3;
end

% distance calculation
if strcmp(distance_type, 'Chi_Square') || (isnumeric(distance_type) && distance_type == 1)
    distance = sum((vector1 - vector2).^2  ./ vector2);
elseif strcmp(distance_type, 'Cross_Entropy') || (isnumeric(distance_type) && distance_type == 2)
    distance = -sum(vector1 .* log(vector2 + eps));
elseif strcmp(distance_type, 'Relative_Entropy') || (isnumeric(distance_type) && distance_type == 3)
    distance = -sum(vector1 .* log(vector1 ./ vector2 + eps));
elseif strcmp(distance_type, 'Jensen_Shannon') || (isnumeric(distance_type) && distance_type == 4)
    M = (vector1 + vector2) / 2;
    distance = 0.5 * sum(vector1 .* log(vector1 ./ M)) + 0.5 * sum(vector2 .* log(vector2 ./ M));
elseif strcmp(distance_type, 'Hellinger') || (isnumeric(distance_type) && distance_type == 5)
    distance = sqrt(1 - sum(sqrt(vector1 .* vector2)));
elseif strcmp(distance_type, 'Bhattacharyya') || (isnumeric(distance_type) && distance_type == 6)
    BC = sum(sqrt(vector1 .* vector2));
    distance = -log(BC);
else
    distance = -1;
end

% round
distance = roundn(distance, -precision);

end