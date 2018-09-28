%% extract QMDCT coefficients in batch (extraction via *.exe)
% - QMDCTs = qmdct_extraction_batch2(audio_files_path, QMDCT_num, audio_nums)
% - Variable:
% ------------------------------------------input
% audio_files_path      audio files path
% QMDCT_num             the number of QMDCT coeffcients, default is 576
% audio_nums            the number of audio files to be processed
% -----------------------------------------output
% QMDCTs                QMDCt matrix, size(QMDCTs) = QMDCT_num * QMDCT_num * N
% N is the number of files to be processed

function QMDCTs = qmdct_extraction_batch2(audio_files_path, QMDCT_num, audio_nums)

[files_list, file_num] = get_files_list(audio_files_path, 'mp3');

if ~exist('QMDCT_num', 'var') || isempty(QMDCT_num)
    QMDCT_num = 576;
end

if ~exist('audio_nums', 'var') || isempty(audio_nums)
    audio_nums = file_num;
end

if file_num == 0
    audio_nums = 0;
end

start_time = tic;

if audio_nums ~= 0
    for i = 1:audio_nums
        audio_file_path = fullfile(audio_files_path, files_list{i});
        QMDCTs(:,:,i)   = get_qmdcts(audio_file_path, 50, QMDCT_num);       %#ok<AGROW>
    end

    QMDCTs = QMDCTs(:,1:QMDCT_num,:);
else
    QMDCTs = -1;
end

end_time = toc(start_time);

fprintf('QMDCT matrix extraction completes, runtime: %.2fs\n', end_time);

end