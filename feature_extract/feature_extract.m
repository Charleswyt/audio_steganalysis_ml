%% Wang-Markov
% - feature = feature_extract(matrix, feature_type, T)
% - Variable:
% ------------------------------------------input
% matrix                QMDCT matrix
% feature_type          type of extracted feature
% T                     threshold value
% -----------------------------------------output
% features              features vector

function feature = feature_extract(matrix, feature_type, T)                 %#ok<STOUT,INUSL>

if ~exist('feature_type', 'var') || isempty(feature_type)
    feature_type = 'wang';
end

if ~exist('T', 'var') || isempty(T)
    if strcmp(feature_type, 'jin')
        T = 6;                                                              %#ok<*NASGU>
    elseif strcmp(feature_type, 'ren')
        T = 4;
    else
        T = 3;
    end
end

command = ['feature = feature_', feature_type, '(matrix, T);'];
eval(command);