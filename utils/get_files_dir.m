%% get the parent director of current file path
% - files_dir = get_files_dir()
% - Variable:
% ------------------------------------------input
% Null
% -----------------------------------------output
% files_dir            the parent directory of the current 

function files_dir = get_files_dir()

current_file_path = pwd;
sep_position = strfind(current_file_path, '\');
files_dir = current_file_path(1:sep_position(end)-1);

end