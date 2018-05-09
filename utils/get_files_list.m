%% Get a list of filenames with extension
% [files_list, files_num] = get_files_list(files_path, files_type)
% - Variable：
% ------------------------------------------input
% files_path        The file path
% file_type         The file type, default: mp3
% ------------------------------------------input
% files_list        the file name list
% files_num         the number of files

function [files_list, files_num] = get_files_list(files_path, files_type)

if ~exist('files_type', 'var') || isempty(files_type)
    files_type = 'mp3';
end

fprintf('The current file path: %s\n', files_path);
fprintf('File type: %s\n', files_type);

appendix  = strcat('*.', files_type);
files_list_struct = dir(fullfile(files_path, appendix));
files_num = length(files_list_struct);
files_list = cell(files_num, 1);

for i = 1 : files_num
    files_list{i} = files_list_struct(i).name;
end

fprintf('The number of files: %d\n', files_num);

end