%% calculate features of concurrence
% - features = get_concurrence_features(matrix, T)
% - Variables:
% ------------------------------------------input
% matrix        concurrence matrix
% T             truncated threshold
% -----------------------------------------output
% features of concurrence

function features = get_concurrence_features(matrix, T)

% default parameters
if ~exist('matrix', 'var') || isempty(matrix)
    matrix = floor(10 * rand(10));
end

if ~exist('T', 'var') || isempty(T)
    T = 300;
end

% truncation
Ad = max(min(matrix,T),-T);

% statistical of concurrence matrix
slide = size(Ad, 1);                                                                % slide of concurence matrix
mean_concurrence = mean(Ad(:));                                      % mean of concurence matrix
concurrence_x = sum(Ad, 2)';                                              % P_{i,0,x}
concurrence_y = sum(Ad, 1);                                               % P_{i,0,y}

% feature extraction
features = zeros(1, 12);
features(1) = sum(Ad(:).^2);
features(2) = max(Ad(:));
features(3) = -sum(Ad(:) .* log(Ad(:) + eps));

for h = 1:slide
    for w = 1:slide
        features(4) = features(4) + Ad(h, w) / (1 + (h - w)^2);
        features(5) = features(5) + (h - mean_concurrence)^2 * Ad(h, w);
        features(6) = features(6) - Ad(h, w) * log(concurrence_x(h) * concurrence_y(w)+eps);
        features(7) = features(7) - concurrence_x(h) * concurrence_y(w) * log(concurrence_x(h) * concurrence_y(w)+eps);
    end
    features(8) = features(8) - Ad(h, h) * log(Ad(h, h) + eps);
    features(9) = features(9) - Ad(h, slide - h + 1) * log(Ad(h, slide - h + 1)+eps);
end

features(10) = -sum(concurrence_x .* log(concurrence_x+eps));
features(11) = -sum(concurrence_y .* log(concurrence_y+eps));

index = 1:slide;
numerator = sum(index .* concurrence_x) * sum(index .* concurrence_y);
denominator1 = sum(concurrence_x .* (index - sum(index .* concurrence_x)).^2);
denominator2 = sum(concurrence_y .* (index - sum(index .* concurrence_y)).^2);

features(12) = numerator / denominator1 / denominator2;

features = features(:);
end