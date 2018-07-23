%% get file name from file path
% - Variable
% ------------------------------input
% file_path     file path
% -----------------------------output
% file_name     file name without extension
% ============================================
% 1)file_name = get_file_name('E:\Myself\2.database\1.wav\wav001.wav')
%   file_name = wav001
%
% 2)file_name = get_file_name('E:/Myself/2.database/1.wav/wav002.wav')
%   file_name = wav002
%
% 3)file_name = get_file_name('E:/Myself/2.database/1.wav\wav003.wav')
%   file_name = wav003
%
% 4)file_name = get_file_name('wav004.wav')
%   file_name = wav004
%
% 5)file_name = get_file_name('\1.wav\wav005.wav')
%   file_name = wav005

function file_name = get_file_name(file_path)

index1 = strfind(file_path, '\');
index2 = strfind(file_path, '/');
if isempty(index1) == 0 && isempty(index2) == 1
    index = index1;
elseif isempty(index1) == 1 && isempty(index2) == 0
    index = index2;
elseif isempty(index1) == 1 && isempty(index2) == 1
    index = [];
else
    index = union(index1, index2);
end

if isempty(index) == 1
    file_path_length = length(file_path);
    file_name = file_path(1 : file_path_length - 4);
else
    size_index = length(index);
    file_path_length = length(file_path);

    file_name = file_path(index(size_index)+1 : file_path_length - 4);          % suppose the length of extension is 3
end

end