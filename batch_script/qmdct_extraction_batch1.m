%% extract QMDCT coefficients in batch (load txt files)
% - QMDCTs = qmdct_extraction_batch1(text_files_path, QMDCT_num, text_nums)
% - Variable:
% ------------------------------------------input
% text_files_path       text files path
% QMDCT_num             the number of QMDCT coeffcients, default is 576
% text_nums             the number of QMDCT coefficients matrix files
% -----------------------------------------output
% QMDCTs                QMDCt matrix, size(QMDCTs) = QMDCT_num * QMDCT_num * N
% N is the number of files to be processed

function QMDCTs = qmdct_extraction_batch1(text_files_path, QMDCT_num, text_nums)

[files_list, file_num] = get_files_list(text_files_path, 'txt');

if ~exist('QMDCT_num', 'var') || isempty(QMDCT_num)
    QMDCT_num = 576;
end

if ~exist('text_nums', 'var') || isempty(text_nums)
    text_nums = file_num;
end

if file_num == 0
    text_nums = 0;
end

start_time = tic;

if text_nums ~= 0
    for i = 1:text_nums
        text_file_path = fullfile(text_files_path, files_list{i});
        QMDCTs(:,:,i)   = load(text_file_path);                             %#ok<AGROW>
    end
    
    QMDCTs = QMDCTs(:,1:QMDCT_num,:);
else
    QMDCTs = -1;
end

end_time = toc(start_time);

fprintf('QMDCT matrix extraction completes, runtime: %.2fs\n', end_time);

end