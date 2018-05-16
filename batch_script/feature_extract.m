%% feature extraction script

feature_cover_files_path = 'E:\Myself\1.source_code\audio_steganalysis_ml\feature\cover';
feature_stego_files_path = 'E:\Myself\1.source_code\audio_steganalysis_ml\feature\stego';
cover_mat_files_path = 'E:\Myself\1.source_code\audio_steganalysis_ml\mat\cover';
stego_mat_files_path = 'E:\Myself\1.source_code\audio_steganalysis_ml\mat\stego';
feature_types = {'jin', 'ren', 'wang', 'wang_new'};
Ts = [6, 4, 3, 3];

if ~exist(feature_cover_files_path, 'file') mkdir(feature_cover_files_path); end    %#ok<SEPEX>
if ~exist(feature_stego_files_path, 'file') mkdir(feature_stego_files_path); end    %#ok<SEPEX>

%% cover
for j = 1:length(feature_types)
    feature_file_path = fullfile(feature_cover_files_path, strcat(feature_types{j}, '_cover_128.mat'));
    if ~exist(feature_file_path, 'file')
        cover_128 = load(fullfile(cover_mat_files_path, 'cover_128.mat'));cover_128 = cover_128.QMDCTs;
        save_feature_file(cover_128, Ts(j), feature_types{j}, feature_file_path);
    end
end

for j = 1:length(feature_types)
    feature_file_path = fullfile(feature_cover_files_path, strcat(feature_types{j}, '_cover_320.mat'));
    if ~exist(feature_file_path, 'file')
        cover_320 = load(fullfile(cover_mat_files_path, 'cover_320.mat'));cover_320 = cover_320.QMDCTs;
        save_feature_file(cover_320, Ts(j), feature_types{j}, feature_file_path);
    end
end

%% stego
[files_list, file_num] = get_files_list(stego_mat_files_path, 'mat');
for i = 1:file_num
    for j = 1:length(feature_types)
        feature_file_path = fullfile(feature_stego_files_path, strcat(feature_types{j}, '_', files_list{i}));
        if ~exist(feature_file_path, 'file')
            mat_file_path = fullfile(stego_mat_files_path, files_list{i});
            QMDCT_matrix = load(mat_file_path);
            QMDCT_matrix = QMDCT_matrix.QMDCTs;
            fprintf('mat:%s, feature:%s', mat_file_path, feature_file_path);
            save_feature_file(QMDCT_matrix, Ts(j), feature_types{j}, feature_file_path);
        end
    end
end

function save_feature_file(matrix, T, feature_type, feature_file_path)
%%¡¡save feature file as mat
%
% - save_feature_file(matrix, T, feature_file_path)
% - Variable:
% ------------------------------------------input
% matrixs           QMDCT coefficients matrix
%                       size(matrix) * N, N is the total number of samples
% T                 threshold value
% feature_file_path the path of feature mat file

if ~exist(feature_file_path, 'file')
    if strcmp(feature_type, 'jin')
        feature = jin_batch(matrix, T);                        %#ok<NASGU>
    elseif strcmp(feature_type, 'ren')
        feature = ren_batch(matrix, T);                        %#ok<NASGU>
    elseif strcmp(feature_type, 'wang')
        feature = wang_batch(matrix, T);                       %#ok<NASGU>
    elseif strcmp(feature_type, 'wang_new')
        feature = wang_new_batch(matrix, T);                   %#ok<NASGU>
    end
    save(feature_file_path, 'feature');
end

end