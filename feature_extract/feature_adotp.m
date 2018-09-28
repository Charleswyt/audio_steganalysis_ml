%% ADOTP(Jin)
% - features = feature_adotp(matrix, T)
% - Variable:
% ------------------------------------------input
% matrix                QMDCT matrix
% T                     threshold value
% -----------------------------------------output
% feature               feature vector

function features = feature_adotp(matrix, T)

if ~exist('T', 'var') || isempty(T)
    T = 6;
end

matrix_abs_dif1 = pre_process_matrix(matrix, 'abs_dif1_v');

features = get_markov(matrix_abs_dif1, 'hv', T, 1);

end