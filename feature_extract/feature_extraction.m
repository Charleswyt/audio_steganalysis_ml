%% Wang-Markov
% - feature = feature_extraction(matrix, feature_type, T)
% - Variable:
% ------------------------------------------input
% matrix                QMDCT matrix
% feature_type          type of extracted feature
% T                     threshold value
% -----------------------------------------output
% features              features vector

function feature = feature_extraction(matrix, feature_type, T)

if ~exist('feature_type', 'var') || isempty(feature_type)
    feature_type = 'wang';
end

if ~exist('T', 'var') || isempty(T)
    if strcmp(feature_type, 'jin')
        T = 6;
    elseif strcmp(feature_type, 'ren')
        T = 4;
    else
        T = 3;
    end
end

if strcmp(feature_type, 'jin')
    feature = feature_jin(matrix, T);
elseif strcmp(feature_type, 'ren')
    feature = feature_ren(matrix, T);
else
    feature = feature_wang(matrix, T);
end