%% wav cut in batch
% - wav_cut_batch(audio_files_path, output_file_path, cut_method, interval, start_index, audio_num, show_info)
% - Variable:
% ------------------------------------------input
% audio_files_path      path of full audio
% output_files_path     path of cut audio
% method                method of cut ("time": duration, "sample": sampling dots)
% interval              interval of cut
% show_info             whether display cut information or not
% -----------------------------------------output
% audio_files_nums      the number of segments which are cut
% if the method of cut is "time", default interval is 10s
% if the method of cut is "sample", default interval is 16000

function wav_cut_batch(audio_files_path, output_file_path, cut_method, interval, show_info)

% argparse
if nargin <= 4
    show_info = 'off';
end

if nargin == 2
    cut_method = 'time';
    interval = 10;
elseif nargin == 3
    if strcmp(cut_method, 'time') == 1
        interval = 10;
    elseif strcmp(cut_method, 'sample') == 1
        interval = 16000;
    else
        cut_method = 'time';
        interval = 10;
    end
end

start_time = tic;

[files_list, files_num] = get_files_list(audio_files_path, 'wav');
audio_files_nums = 0;

if files_num == 0
    fprintf('The audio file is not wav, please try again.\n');
else
    
    if strcmp(cut_method, 'time') == 1
        if interval < 1
            interval = 1;
        end
        for i = 1 : files_num
            audio_file_path = fullfile(audio_files_path, files_list{i});
            audio_files_num = wav_cut_time(audio_file_path, interval, output_file_path, show_info);
            if audio_files_num > 1
                audio_files_nums = audio_files_nums + audio_files_num;
            end
        end
    elseif strcmp(cut_method, 'sample') == 1
        if interval < 16000
            interval = 16000;
        end
        for i = 1 : files_num
            audio_file_path = fullfile(audio_files_path, files_list{i});
            audio_files_num = wav_cut_sample(audio_file_path, interval, output_file_path, show_info);
            if audio_files_num > 1
                audio_files_nums = audio_files_nums + audio_files_num;
            end
        end
    end
end
fprintf('Segments from this audio file: %d\n', audio_files_nums);

end_time = toc(start_time);
fprintf('Run time: %.2f s\n', end_time);

end