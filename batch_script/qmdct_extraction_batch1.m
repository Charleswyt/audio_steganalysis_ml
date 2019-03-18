%% extract QMDCT coefficients in batch (load txt files)
% - QMDCTs = qmdct_extraction_batch1(text_files_path, QMDCT_num, text_nums)
% - Variable:
% ------------------------------------------input
% text_files_path       text files path
% QMDCT_num             the number of QMDCT coeffcients, default is 576
% start_index           the start index of text files
% text_nums             the number of QMDCT coefficients matrix files
% -----------------------------------------output
% QMDCTs                QMDCt matrix, size(QMDCTs) = QMDCT_num * QMDCT_num * N
% N is the number of files to be processed

function QMDCTs = qmdct_extraction_batch1(text_files_path, QMDCT_num, start_index, text_nums)

[files_list, file_num] = get_files_list(text_files_path, 'txt');

if ~exist('QMDCT_num', 'var') || isempty(QMDCT_num)
    QMDCT_num = 576;
end

if ~exist('start_index', 'var') || isempty(start_index)
    start_index = 0;
end

if (~exist('text_nums', 'var') || isempty(text_nums)) && start_index == 0
    text_nums = file_num;
end

if start_index + text_nums - 1 > file_num || file_num == 0
    text_nums = 0;
end

if start_index - 1 > file_num
    start_index = 0;
end

start_time = tic;

if text_nums ~= 0
    count = 0;
    for i = start_index : (start_index + text_nums - 1)
        text_file_path = fullfile(text_files_path, files_list{i});
        QMDCTs(:,:,i - start_index + 1)  = load(text_file_path);            %#ok<AGROW>
        fprintf(repmat('\b', 1, count));
        count = fprintf('QMDCT file: %s', files_list{i});
    end
    
    QMDCTs = QMDCTs(:,1:QMDCT_num,:);
else
    QMDCTs = -1;
end

end_time = toc(start_time);

fprintf('\n');
fprintf('QMDCT matrix extraction completes, runtime: %.2fs\n', end_time);

end