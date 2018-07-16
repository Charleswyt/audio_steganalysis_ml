%% feature extraction

width = [2, 3];
bitrate = [128, 192, 256, 320];
embeding_rate = [1, 3, 5, 8, 10];
stego_method = {'EECS', 'HCM'};
feature_type = {'jin', 'ren', 'wang'};

QMDCT_num = 576;
text_nums = 1000;

data_cover_mat_dir = 'E:\Myself\2.database\mtap\data_mat\cover';
data_stego_mat_dir = 'E:\Myself\2.database\mtap\data_mat\stego';


for s = 1:length(stego_method)
    for b = 1:length(bitrate)
        % folder of cover files
        if strcmp(stego_method{s}, 'MP3Stego')
            cover_files_name = ['mp3stego_', num2str(bitrate(b))];
        else
            cover_files_name = num2str(bitrate(b));
        end
        % extract QMDCT coefficients and save it as a  mat file
        cover_files_path  = fullfile(cover_dir, cover_files_name);
        QMDCT = qmdct_extract_batch(cover_files_path, QMDCT_num, text_nums);
        cover_mat_path = [fullfile(data_cover_mat_dir, cover_files_name), '.mat'];
        save(fullfile(data_mat_dir, cover_mat_path), 'QMDCT');
        fpritnf('QMDCT coefficients - %s completes.\n', cover_files_path);
        
        % folder of stego files
        for e = 1:length(embedding_rate)
            if strcmp(stego_method{s}, 'EECS')
                for w = 1:length(width)
                    stego_files_name = [stego_method{s}, '_W_', num2str(width(w)), '_B_', num2str(bitrate(b)), '_ER_', num2str(embedding_rate(e))];
                end
            else
                stego_files_name = [stego_method{s}, '_B_', num2str(bitrate(b)), '_ER_', num2str(embedding_rate(e))];
            end
            stego_files_path  = fullfile(steog_dir, steog_files_name);
            QMDCT = qmdct_extract_batch(stego_files_path, QMDCT_num, text_nums);
            stego_mat_path = [fullfile(data_stego_mat_dir, stego_method{s}, cover_files_name), '.mat'];
            save(fullfile(data_mat_dir, stego_mat_path), 'QMDCT');
            fpritnf('QMDCT coefficients - %s completes.\n', stego_files_name);
        end
    end
end
            
            