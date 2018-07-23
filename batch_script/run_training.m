%% training batch

percent = 0.8;
width = [2, 3];
bitrate = [128, 192, 256, 320];
stego_method = {'MP3Stego', 'HCM', 'EECS'};
feature_type = {'jin', 'ren', 'wang'};
embedding_rate = [3, 5, 8, 10];

feature_cover_mat_dir = 'E:\Myself\2.database\mtap\feature_mat\cover';
feature_stego_mat_dir = 'E:\Myself\2.database\mtap\feature_mat\stego';

result_file_path = 'results.txt';
fid = fopen(result_file_path, 'w');

for f = 1:length(feature_type)
    for b = 1:length(bitrate)
        feature_cover_path = fullfile(feature_cover_mat_dir, feature_type{f}, [num2str(bitrate(b)), '.mat']);
        if exist(feature_cover_path, 'file')
            feature_cover_file = load(feature_cover_path);
            feature_cover = feature_cover_file.features;
        end
        
        for s = 1:length(stego_method)
            if strcmp(stego_method{s}, 'EECS')
                for w = 1:length(width)
                    for e = 1:length(embedding_rate)
                        if embedding_rate(e) == 10
                            feature_stego_name = [stego_method{s}, '_B_', num2str(bitrate(b)), '_W_', num2str(width(w)), '_H_7_ER_', num2str(embedding_rate(e))];
                        else
                            feature_stego_name = [stego_method{s}, '_B_', num2str(bitrate(b)), '_W_', num2str(width(w)), '_H_7_ER_0', num2str(embedding_rate(e))];
                        end
                        feature_stego_path = fullfile(feature_stego_mat_dir, stego_method{s}, feature_type{f}, [feature_stego_name, '.mat']);
                        if exist(feature_stego_path, 'file')
                            feature_stego_file = load(feature_stego_path);
                            feature_stego = feature_stego_file.features;
                            try
                                result = training(feature_cover, feature_stego, percent);
                                fprintf('%s %s %4.2f %4.2f %4.2f\r\n', feature_type{f}, feature_stego_name, 100*result.FPR, 100*result.FNR, 100*result.ACC);
                                fprintf(fid,'%s %s %4.2f %4.2f %4.2f\r\n', feature_type{f}, feature_stego_name, 100*result.FPR, 100*result.FNR, 100*result.ACC);
                            catch
                                continue;
                            end
                        end
                    end
                end
            else
                for e = 1:length(embedding_rate)
                    if embedding_rate(e) == 10
                        feature_stego_name = [stego_method{s}, '_B_', num2str(bitrate(b)), '_ER_', num2str(embedding_rate(e))];
                    else
                        feature_stego_name = [stego_method{s}, '_B_', num2str(bitrate(b)), '_ER_0', num2str(embedding_rate(e))];
                    end
                    feature_stego_path = fullfile(feature_stego_mat_dir, stego_method{s}, feature_type{f}, [feature_stego_name, '.mat']);
                    if exist(feature_stego_path, 'file')
                        feature_stego_file = load(feature_stego_path);
                        feature_stego = feature_stego_file.features;
                        try
                            result = training(feature_cover, feature_stego, percent);
                            fprintf('%s %s %4.2f %4.2f %4.2f\r\n', feature_type{f}, feature_stego_name, 100*result.FPR, 100*result.FNR, 100*result.ACC);
                            fprintf(fid,'%s %s %4.2f %4.2f %4.2f\r\n', feature_type{f}, feature_stego_name, 100*result.FPR, 100*result.FNR, 100*result.ACC);
                        catch
                            continue;
                        end
                    end
                end
            end
        end
        fprintf(fid,'-----------------------------\r\n');
    end
    fprintf(fid,'=================================\r\n');
end

fclose(fid);