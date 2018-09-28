%% feature extraction
% - feature = feature_extraction(matrix, feature_type, T)
% - Variable:
% ------------------------------------------input
% matrix                QMDCT matrix
% feature_type          type of extracted feature
% option: ADOPT(jin), MDI2(ren), JPBC(wang-IS), I2C(wang-CIHW), D2MA(qiao), Occurance(Yan)
% T                     threshold value
% -----------------------------------------output
% features              features vector

function feature = feature_extraction(matrix, feature_type, T)

if ~exist('feature_type', 'var') || isempty(feature_type)
    feature_type = 'jpbc';
end

if ~exist('T', 'var') || isempty(T)
    if strcmp(feature_type, 'ADOTP')
        T = 6;
    elseif strcmp(feature_type, 'MDI2')
        T = 4;
    elseif strcmp(feature_type, 'I2C')
        T = 3;
    elseif strcmp(feature_type, 'JPBC')
        T = 5;
    elseif strcmp(feature_type, 'D2MA')
        T = 4;
    elseif strcmp(feature_type, 'Co-Occurrence')
        T = 15;
    else
        T = 5;
    end
end

if strcmp(feature_type, 'ADOTP')
    feature = feature_adotp(matrix, T);
elseif strcmp(feature_type, 'MDI2')
    feature = feature_mdi2(matrix, T);
elseif strcmp(feature_type, 'I2C')
    feature = feature_i2c(matrix, T);
elseif strcmp(feature_type, 'JPBC')
    feature = feature_jpbc(matrix, T);
elseif strcmp(feature_type, 'D2MA')
    feature = feature_d2ma(matrix, T);
elseif strcmp(feature_type, 'D2MA')
    feature = feature_occurance(matrix, T);
else
    feature = feature_jpbc(matrix, T);
end