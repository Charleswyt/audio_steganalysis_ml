%% feature extraction

stego_method = {'MP3Stego', 'HCM', 'EECS'};
feature_type = {'jin', 'ren', 'jpbc', 'wang'};
T = [6, 4, 5, 3];

QMDCT_num = 500;
text_nums = 1000;

data_cover_mat_dir = 'E:\Myself\2.database\mtap\data_mat\cover';
data_stego_mat_dir = 'E:\Myself\2.database\mtap\data_mat\stego';
feature_cover_mat_dir = 'E:\Myself\2.database\mtap\feature_mat\cover';
feature_stego_mat_dir = 'E:\Myself\2.database\mtap\feature_mat\stego';

[cover_files_list, cover_file_num] = get_files_list(data_cover_mat_dir, 'mat');
for fn = 1:cover_file_num
    QMDCT_file_path = fullfile(data_cover_mat_dir, cover_files_list{fn});
    if exist(QMDCT_file_path, 'file')
        QMDCT_file = load(QMDCT_file_path);QMDCT = QMDCT_file.QMDCT;
        QMDCT = QMDCT(:, 1:QMDCT_num, :);
        for f = 1:length(feature_type)
            feature_cover_path = fullfile(feature_cover_mat_dir, feature_type{f});
            if ~exist(feature_cover_path, 'file')
                mkdir(feature_cover_path);
            end
            features_file_path = fullfile(feature_cover_path, cover_files_list{fn});
            if ~exist(features_file_path, 'file')
                features = feature_extraction_batch(QMDCT, feature_type{f}, T(f));
                save(features_file_path, 'features');
                fprintf('%s features extraction completes, %s.\n', feature_type{f}, cover_files_list{fn});
            end
        end
    end
end

for s = 1:length(stego_method)
    data_stego_mat_path = fullfile(data_stego_mat_dir, stego_method{s});
    [stego_files_list, stego_file_num] = get_files_list(data_stego_mat_path, 'mat');
    for fn = 1:stego_file_num
        QMDCT_file_path = fullfile(data_stego_mat_path, stego_files_list{fn});
        if exist(QMDCT_file_path, 'file')
            QMDCT_file = load(QMDCT_file_path);QMDCT = QMDCT_file.QMDCT;
            QMDCT = QMDCT(:, 1:QMDCT_num, :);
            for f = 1:length(feature_type)
                feature_stego_mat_path = fullfile(feature_stego_mat_dir, stego_method{s}, feature_type{f});
                if ~exist(feature_stego_mat_path, 'file')
                	mkdir(feature_stego_mat_path);
                end
                features_file_path = fullfile(feature_stego_mat_path, stego_files_list{fn});
                if ~exist(features_file_path, 'file')
                    features = feature_extraction_batch(QMDCT, feature_type{f}, T(f));
                    save(features_file_path, 'features');
                    fprintf('%s features extraction completes, %s.\n', feature_type{f}, stego_files_list{fn});
                end
            end
        end
    end
end