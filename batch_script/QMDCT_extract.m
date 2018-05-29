%% load QMDCT coefficients into the memory from txt file
% name_format:  cover_128
%               EECS_B_128_W_6_T_0_ER_10

[QMDCT_num, files_num] = deal(576, 1000);
cover_types = {'MP3Stego'};
steg_algorithms = {'ACS', 'EECS', 'HCM', 'AHCM', 'MP3Stego'};
bitrates = {'128', '192', '256', '320'};
capacities = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '10'};
thresholds = {'0', '1', '2', '3', '4'};
embedding_rates = {'01', '03', '05', '08', '10'};

root_path = 'H:\ToWYT3';
mat_files_path = 'E:\Myself\1.source_code\audio_steganalysis_ml\mat';

mat_cover_files_path = fullfile(mat_files_path, 'cover');
mat_stego_files_path = fullfile(mat_files_path, 'stego');

if ~exist(root_path, 'file')
    fprintf('The QMDCT files floder does not exist.\n');
else
    if ~exist(mat_cover_files_path, 'file')
        mkdir(mat_cover_files_path)
    end
    
    if ~exist(mat_stego_files_path, 'file')
        mkdir(mat_stego_files_path)
    end

%% cover
    for i = 1;length(cover_types)
        for j = 1:length(bitrates)
            file_name = strcat(cover_types{i}, '_', bitrates{j});
            file_path = fullfile(root_path, file_name);
            if ~exist(file_path, 'file')
                continue;
            else
                mat_file_path = fullfile(mat_cover_files_path, strcat(file_name, '.mat'));
                if ~exist(mat_file_path, 'file')
                    QMDCTs = qmdct_extract_batch(file_path, QMDCT_num, files_num);
                    save(mat_file_path, 'QMDCTs');
                    fprintf('%s extraction completes.\n', file_name);
                end
            end
        end
    end

%% stego
    for i = 1:length(steg_algorithms)
        for j = 1:length(bitrates)
            for m = 1:length(capacities)
                for n = 1:length(thresholds)
                    for k = 1:length(embedding_rates)
                        file_name = strcat(steg_algorithms{i}, '_B_', bitrates{j}, '_W_', capacities{m}, '_T_', thresholds{n}, '_ER_', embedding_rates{k});
                        fprintf('%s\n', file_name);
                        file_path = fullfile(root_path, file_name);
                        if ~exist(file_path, 'file')
                            continue;
                        else
                            mat_file_path = fullfile(mat_stego_files_path, strcat(file_name, '.mat'));
                            if ~exist(mat_file_path, 'file')
                                QMDCTs = qmdct_extract_batch(file_path, QMDCT_num, files_num);
                                save(mat_file_path, 'QMDCTs');
                                fprintf('%s extraction completes.\n', file_name);
                            end
                        end
                    end
                end
            end
        end
    end
end