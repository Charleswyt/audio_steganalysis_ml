%% extract QMDCT coefficients in batch (批量提取mp3文件的QMDCT系数)
% - QMDCTs = qmdct_extract_batch(audio_files_path, QMDCT_num, audio_nums, del_flag)
% - Variable:
% ------------------------------------------input
% text_files_path       audio files path (QMDCT文件路径)
% QMDCT_num             the number of QMDCT coeffcients, default is 576 (QMDCT系数个数, 默认�?576)
% audio_nums            the number of audio files to be processed (待提取的音频文件个数(默认为当前路径下的所有文�?))
% -----------------------------------------output
% QMDCTs                QMDCt matrix (生成的QMDCT系数矩阵), size(QMDCTs) = QMDCT_num * QMDCT_num * N
% N is the number of files to be processed

function QMDCTs = qmdct_extract_batch(text_files_path, QMDCT_num, text_nums)

[files_list, file_num] = get_files_list(text_files_path, 'txt');

if ~exist('QMDCT_num', 'var') || isempty(QMDCT_num)
    QMDCT_num = 576;
end

if ~exist('text_nums', 'var') || isempty(text_nums)
    text_nums = file_num;
end

start_time = tic;

for i = 1:text_nums
    text_file_path = fullfile(text_files_path, files_list{i});
    QMDCTs(:,:,i)   = load(text_file_path);                         %#ok<AGROW>
end

end_time = toc(start_time);

QMDCTs = QMDCTs(:,1:QMDCT_num,:);

fprintf('QMDCT matrix extraction completes, runtime: %.2fs\n', end_time);

end