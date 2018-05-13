%% load feature
feature_cover_files_path = 'E:\Myself\1.source_code\audio_steganalysis_ml\feature\cover';
feature_stego_files_path = 'E:\Myself\1.source_code\audio_steganalysis_ml\feature\stego';
bitrates = {'128', '320'};
feature_types = {'jin', 'ren', 'wang'};

% cover
for i = 1:length(feature_types)
    for j = 1:length(bitrates)
        variable_name = strcat(feature_types{i}, '_cover_', bitrates{j});
        feature_file_path = fullfile(feature_cover_files_path, strcat(variable_name, '.mat'));
        command = strcat(variable_name, '=load(''', feature_file_path, ''');', variable_name, '=', variable_name, '.feature;');
        eval(command);
    end
end

% stego
[files_list, file_num] = get_files_list(feature_stego_files_path, 'mat');
for k =1:file_num
    file_name = strsplit(files_list{k}, '.mat');file_name = file_name{1};
    variable_name = strrep(file_name, '.', '');
    feature_file_path = fullfile(feature_stego_files_path, strcat(file_name, '.mat'));
    command = strcat(variable_name, '=load(''', feature_file_path, ''');', variable_name, '=', variable_name, '.feature;');
    fprintf('%s\n', command);
    eval(command);
end