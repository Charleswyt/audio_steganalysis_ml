%% calculate the statistical characteristics
% [mean_value, var, skew, kurt] = get_statistical_characteristics(vector)
% - Variable:
% ------------------------------------------input
% vector            input vector
% -----------------------------------------output
% mean_value        mean     of input vector
% var               variance of input vector
% skew              skewness of input vector
% kurt              kurtosis of input vector

function [mean_value, var, skew, kurt] = statistical_characteristics(vector)

mean_value = mean(vector);
var  = std(vector) * std(vector);
skew = skewness(vector);
kurt = kurtosis(vector);

% fprintf('mean     of input vector is %.2f', mean_value);
% fprintf('variance of input vector is %.2f', var);
% fprintf('skewness of input vector is %.2f', skew);
% fprintf('kurtosis of input vector is %.2f', kurt);

end