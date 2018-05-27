%% load feature from disk

feature_cover_files_path = 'E:\Myself\1.source_code\audio_steganalysis_ml\feature\cover';
feature_stego_files_path = 'E:\Myself\1.source_code\audio_steganalysis_ml\feature\stego';
files_paths = {feature_cover_files_path, feature_stego_files_path};

start_time = tic;
for m = 1:length(files_paths)
    files_path = files_paths{m};
    [files_list, file_num] = get_files_list(files_path, 'mat');
    for k =1:file_num
        file_name = strsplit(files_list{k}, '.mat');file_name = file_name{1};
        variable_name = strrep(file_name, '.', '');
        feature_file_path = fullfile(files_path, strcat(file_name, '.mat'));
        if ~exist(feature_file_path, 'file')
            continue;
        else
            command = strcat(variable_name, '=load(''', feature_file_path, ''');', variable_name, '=', variable_name, '.feature;');
            fprintf('feature %s is loaded.\n', variable_name);
            eval(command);
        end
    end
end

end_time = toc(start_time);
fprintf('Feature loads completes, runtime: %.2fs\n', end_time);