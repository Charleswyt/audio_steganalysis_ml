%% wav cut in way of time cut
% - auido_files_num = wav_cut_time(audio_file_path, time_interval, output_files_path, show_info)
% - Input
% ------------------------------------------input
% audio_file_path       单个音频文件路径
% time_interval         裁剪长度（10s / 30s / 60s）
% output_files_path     裁剪文件存储路径
% show_info             确认是否打印运行信息
% -----------------------------------------output
% audio_files_num       当前音频文件裁剪出的片段个数
% 所有变量的单位均为秒，默认interval为10s
% Fs：Frequency Sample，采样频率，表示每秒多少个采样点
% =========================================================================
% 1)auido_files_num = wav_cut_time(audio_file_path)
%   读取audio_file_path对应的音频文件，将其以10s为间隔进行切分
%   切割后的音频保存至'E:\Myself\2.database\2.wav_cut\wav_10s'路径下，打印切分信息
%
% 2)auido_files_num = wav_cut_time(audio_file_path, time_interval)
%   读取audio_file_path对应的音频文件，将其以 'time_interval' 为间隔进行切分
%   切割后的音频保存至"E:\Myself\2.database\2.wav_cut\wav_'time_interval's"路径下，打印切分信息
%
% 3)auido_files_num = wav_cut_time(audio_file_path, time_interval, output_files_path)
%   读取audio_file_path对应的音频文件，将其以 'time_interval' 为间隔进行切分
%   切割后的音频保存至"E:\Myself\2.database\2.wav_cut\wav_'time_interval's"路径下
%   打印切分信息
%
% 4)auido_files_num = wav_cut_time(audio_file_path, time_interval, output_files_path, show_info)
%   读取audio_file_path对应的音频文件，将其以 'time_interval' 为间隔进行切分
%   切割后的音频保存至"E:\Myself\2.database\2.wav_cut\wav_'time_interval's"路径下
%   根据show_info标识符确认是否打印切分信息

function auido_files_num = wav_cut_time(audio_file_path, time_interval, output_files_path, show_info)

% 默认裁剪时长为10秒
if nargin == 1
    time_interval = 10;
    output_files_path = 'E:\Myself\2.database\2.wav_cut\wav_10s';
    show_info = 'on';
end

% 默认裁剪保存路径
if nargin == 2
    output_files_path = strcat('E:\Myself\2.database\2.wav_cut\wav_', num2str(time_interval), 's');
    show_info = 'on';
end

% 默认打印信息
if nargin == 3
    show_info = 'on';
end

audio_file_name = get_file_name(audio_file_path);                               % 音频文件名
[audio_stream, Fs] = audioread(audio_file_path);                                % 读取音频
audio_length = length(audio_stream);                                            % 音频采样点数
audio_time = floor(audio_length / Fs);                                          % 音频总时长
fprintf('当前音频文件：%s\n', audio_file_name);                                  % 打印信息

cut_time = 10;                                                                  % 略去的时间
audio_stream = audio_stream(cut_time * Fs + 1 : ...
    audio_length - cut_time * Fs, :);                                           % 略去前10秒和后10秒，避免静音片段
fragments = floor((audio_time - 20) / time_interval);                           % 计算可切分的片段
auido_files_num = fragments;

if fragments < 1
    fprintf('当前音频文件不能完成该interval下的切割...\n');
else
    start_time = 1;
    segment = time_interval * Fs;                                               % 每个fragment的采样点数
    if strcmp(show_info, 'on') == 1
        for i = 1 : fragments
            output_stream = audio_stream(start_time + (i-1) * segment: ...
                start_time + i * segment - 1, :);                               % 输出音频流
            audio_name = strcat(audio_file_name, '_cut_', num2str(i), '.wav');  % 输出音频流文件名
            fprintf('audio %d-th：%s\n', i, audio_name);                        % 打印信息
            output_audio_file_path = fullfile(output_files_path, audio_name);   % 输出音频流路径
            audiowrite(output_audio_file_path, output_stream, Fs);              % 将文件写出
        end
        
    else
        for i = 1 : fragments
            try
                output_stream = audio_stream(start_time + (i-1) * segment: ...
                    start_time + i * segment, :);                                   % 输出音频流
                audio_name = strcat(audio_file_name, '_cut_', num2str(i), '.wav');  % 输出音频流文件名
                output_audio_file_path = fullfile(output_files_path, audio_name);   % 输出音频流路径
                audiowrite(output_audio_file_path, output_stream, Fs);              % 将文件写出
            catch
                continue;
            end
        end
    end
fprintf('当前音频总时长%ds  裁剪音频时长%ds 裁剪音频%d个\n', ...
    audio_time, time_interval, fragments);    
end

end