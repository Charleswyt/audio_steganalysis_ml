cover_mat_files_path = 'E:\Myself\1.source_code\audio_steganalysis_ml\mat\cover';
stego_mat_files_path = 'E:\Myself\1.source_code\audio_steganalysis_ml\mat\stego';

% cover_128 = load(fullfile(cover_mat_files_path, 'cover_128.mat'));cover_128 = cover_128.QMDCTs;
% cover_320 = load(fullfile(cover_mat_files_path, 'cover_320.mat'));cover_320 = cover_320.QMDCTs;

[files_list, file_num] = get_files_list(stego_mat_files_path, 'mat');

for i = 1:file_num
    if ~isempty(strfind(files_list{i}, '128'))
        QMDCT
        
        
end