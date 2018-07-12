%% get the statistical characteristics
% [mean_value, var, skew, kurt] = get_statistical_characteristics(vector)
% - Variable:
% ------------------------------------------input
% vector            input vector
% -----------------------------------------output
% mean_value        mean     of input vector
% var               variance of input vector
% skew              skewness of input vector
% kurt              kurtosis of input vector

cover = load('E:\Myself\2.database\mtap\mp3\cover\128\wav10s_00001.txt');
stego = load('E:\Myself\2.database\mtap\mp3\stego\EECS\EECS_W_2_B_128_ER_10\wav10s_00001_stego_128.txt');

T = [3,4,5,6,7,8,9,10,11,12,13,14,15];

for t = T
    feature_cover = wang_matrices_select(cover, t);
    feature_stego = wang_matrices_select(stego, t);
    
    [mean_value_cover, var_cover, skew_cover, kurt_cover] = statistical_characteristics(feature_cover);
    [mean_value_stego, var_stego, skew_stego, kurt_stego] = statistical_characteristics(feature_stego);
    
    mean_value_dif = mean_value_cover - mean_value_stego;
    var_dif  = var_cover - var_stego;
    skew_dif = skew_cover - skew_stego;
    kurt_dif = kurt_cover - kurt_stego;
    
    fprintf('=================\n');
    fprintf('T=%d\n', t);
    fprintf('mean    : %.2f\n', mean_value_dif);
    fprintf('variance: %.2f\n', var_dif);
    fprintf('skewness: %.2f\n', skew_dif);
    fprintf('kurtosis: %.2f\n', kurt_dif);
end
    

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