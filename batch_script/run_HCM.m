T = 3;
bitrates = [128, 192, 256, 320];
embedding_rates = [1, 3, 5, 8, 10];

cover_dir = 'E:\Myself\2.database\mtap\txt\cover';
stego_dir = 'E:\Myself\2.database\mtap\txt\stego\HCM';
data_dir = 'E:\Myself\1.source_code\audio_steganalysis_ml\mat_data';
feature_dir = 'E:\Myself\1.source_code\audio_steganalysis_ml\mat_feature';

QMDCT_num = 500;
text_nums = 1000;

for b = 1:length(bitrates)
    cover_files_path = fullfile(cover_dir, num2str(bitrates(b)));
    cover_mat_path = ['cover_', num2str(bitrates(b)), '.mat'];
    QMDCT_cover = qmdct_extract_batch(cover_files_path, QMDCT_num, text_nums);
    feature_cover = wang_new_batch(QMDCT_cover, T, text_nums);
    save(fullfile(data_dir, cover_mat_path), 'QMDCT_cover');
    save(fullfile(feature_dir, cover_mat_path), 'feature_cover');
    for e = 1:length(embedding_rates)
        if embedding_rates(e) == 10
            stego_file_name = ['HCM_B_', num2str(bitrates(b)), '_ER_' num2str(embedding_rates(e))];
        else
            stego_file_name = ['HCM_B_', num2str(bitrates(b)), '_ER_0' num2str(embedding_rates(e))];
        end
        stego_files_path = fullfile(stego_dir, stego_file_name);
        QMDCT_stego = qmdct_extract_batch(stego_files_path, QMDCT_num, text_nums);
        stego_mat_path = [stego_file_name, '.mat'];
        if exist(stego_files_path, 'file')
            save(fullfile(data_dir, stego_mat_path), 'QMDCT_stego');
            feature_stego = wang_new_batch(QMDCT_stego, T, text_nums);
            result = training(feature_cover, feature_stego, 0.8);
            results.stego = stego_file_name;
            [results.FPR, results.FNR, results.ACC] = deal(result.FPR, result.FNR, result.ACC);
            save(fullfile(feature_dir, stego_mat_path), 'feature_stego');
        else
            continue;
        end
    end
end