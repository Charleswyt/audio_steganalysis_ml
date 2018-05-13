%% load QMDCT coefficients into the memory from txt file

prefixs = {'acs_t_2_w_2', 'acs_t_3_w_2', 'eecs_w_2', 'yan_w_2'};
bitrates = {'128', '320'};
embedding_rates = {'0.1', '0.3', '0.5', '0.8', '1.0'};

root_path = 'C:\Users\Charles_CatKing\Desktop\QMDCT';
mat_files_path = 'E:\Myself\1.source_code\audio_steganalysis_ml\mat';

if ~exist(mat_files_path, 'file')
    mkdir(mat_files_path)
end

QMDCT_num = 576;
text_nums = 1000;

for i = 1:length(prefixs)
    for j = 1:length(bitrates)
        for k = 1:length(embedding_rates)
            file_name = strcat(prefixs{i}, '_', bitrates{j}, '_', embedding_rate{k});
            file_path = fullfile(root_path, file_name);
            mat_file_path = fullfile(mat_files_path, strcat(file_name, '.mat'));
            if ~exist(mat_file_path, 'file')
                QMDCTs = qmdct_extract_batch(file_path, QMDCT_num, text_nums);  %#ok<NASGU>
                save(mat_file_path, 'QMDCTs');
            end
        end
    end
end

file_path = fullfile(root_path, 'cover_128');
mat_file_path = fullfile(mat_files_path, strcat('cover_128', '.mat'));
QMDCTs = qmdct_extract_batch(file_path, QMDCT_num, text_nums);                %#ok<NASGU>
if ~exist(mat_file_path, 'file')
    save(mat_file_path, 'QMDCTs');
end

file_path = fullfile(root_path, 'cover_320');
mat_file_path = fullfile(mat_files_path, strcat('cover_320', '.mat'));
QMDCTs = qmdct_extract_batch(file_path, QMDCT_num, text_nums);
if ~exist(mat_file_path, 'file')
    save(mat_file_path, 'QMDCTs');
end