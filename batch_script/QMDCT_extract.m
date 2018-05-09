prefixs = {'acs_t_2_w_2', 'acs_t_3_w_2', 'eecs_w_2', 'yan_w_2'};
bitrates = {'128', '320'};
embedding_rates = {'0.1', '0.3', '0.5', '0.8', '1.0'};

root_path = 'C:\Users\Charles_CatKing\Desktop\QMDCT';
mat_file_path = 'E:\Myself\1.source_code\audio_steganalysis_ml\mat\';

QMDCT_num = 576;
text_nums = 1000;

for i = 1:length(prefixs)
    for j = 1:length(bitrates)
        for k = 1:length(embedding_rates)
            file_name = strcat(prefixs{i}, '_', bitrates{j}, '_', embedding_rate{k});
            file_path = fullfile(root_path, file_name);
            QMDCTs = qmdct_extract_batch(file_path, QMDCT_num, text_nums);
            save(strcat(mat_file_path, file_name, '.mat'), 'QMDCTs');
        end
    end
end