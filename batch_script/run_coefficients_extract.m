%% QMDCT coefficients matrix load from txt files

width = [2, 3, 4, 5];
bitrate = [128, 192, 256, 320];
embedding_rate = [3, 5, 8, 10];
stego_method = {'MP3Stego', 'EECS', 'HCM'};

QMDCT_num = 576;
text_nums = 1000;

cover_dir = 'E:\Myself\2.database\mtap\txt\cover';
steog_dir = 'E:\Myself\2.database\mtap\txt\stego';
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
        cover_mat_path = [fullfile(data_cover_mat_dir, cover_files_name), '.mat'];
        if ~exist(cover_mat_path, 'file')
            QMDCT = qmdct_extract_batch(cover_files_path, QMDCT_num, text_nums);
            if all(all(QMDCT)) == 1
                save(cover_mat_path, 'QMDCT');
                fprintf('QMDCT coefficients - %s completes.\n', cover_files_path);
            end
        end
        
        % folder of stego files
        for e = 1:length(embedding_rate)
            if strcmp(stego_method{s}, 'EECS')
                for w = 1:length(width)
                    if embedding_rate(e) == 10
                        stego_files_name = [stego_method{s}, '_B_', num2str(bitrate(b)), '_W_', num2str(width(w)), '_H_7_ER_', num2str(embedding_rate(e))];
                    else
                        stego_files_name = [stego_method{s}, '_B_', num2str(bitrate(b)), '_W_', num2str(width(w)), '_H_7_ER_0', num2str(embedding_rate(e))];
                    end
                    stego_files_path  = fullfile(steog_dir, stego_method{s}, stego_files_name);
                    stego_mat_path = [fullfile(data_stego_mat_dir, stego_method{s}, stego_files_name), '.mat'];
                    if ~exist(stego_mat_path, 'file')
                        QMDCT = qmdct_extract_batch(stego_files_path, QMDCT_num, text_nums);
                        if all(all(QMDCT)) == 1
                            save(stego_mat_path, 'QMDCT');
                            fprintf('QMDCT coefficients - %s completes.\n', stego_files_name);
                        end
                    end
                end
            else
                if embedding_rate(e) == 10
                    stego_files_name = [stego_method{s}, '_B_', num2str(bitrate(b)), '_ER_', num2str(embedding_rate(e))];
                else
                    stego_files_name = [stego_method{s}, '_B_', num2str(bitrate(b)), '_ER_0', num2str(embedding_rate(e))];
                end
                stego_files_path  = fullfile(steog_dir, stego_method{s}, stego_files_name);
                stego_mat_path = [fullfile(data_stego_mat_dir, stego_method{s}, stego_files_name), '.mat'];
                if ~exist(stego_mat_path, 'file')
                    QMDCT = qmdct_extract_batch(stego_files_path, QMDCT_num, text_nums);
                    if all(all(QMDCT)) == 1
                        save(stego_mat_path, 'QMDCT');
                        fprintf('QMDCT coefficients - %s completes.\n', stego_files_name);
                    end
                end
            end
        end
    end
end