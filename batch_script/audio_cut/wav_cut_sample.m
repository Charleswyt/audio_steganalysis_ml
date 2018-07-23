%% wav音频裁剪脚本(实现对整首歌曲的等间隔切分)
% - auido_files_num = wav_cut_sample(audio_file_path, sample_interval, output_files_path, show_info)
% - 变量说明：
% ------------------------------------------input
% audio_file_path       单个音频文件路径
% sample_interval       裁剪长度（16000个采样点）
% output_files_path     裁剪文件存储路径
% show_info             确认是否打印运行信息
% -----------------------------------------output
% audio_files_num       当前音频文件裁剪出的片段个数
% =========================================================================
% 1)auido_files_num = wav_cut_time(audio_file_path)
%   读取audio_file_path对应的音频文件，将其以1600个采样点为间隔进行切分
%   切割后的音频保存至'E:\Myself\2.database\2.wav_cut\wav_16000'路径下，打印切分信息
%
% 2)auido_files_num = wav_cut_time(audio_file_path, time_interval)
%   读取audio_file_path对应的音频文件，将其以 'sample_interval' 为间隔进行切分
%   切割后的音频保存至"E:\Myself\2.database\2.wav_cut\wav_'sample_interval'"路径下，打印切分信息
%
% 3)auido_files_num = wav_cut_time(audio_file_path, time_interval, output_files_path)
%   读取audio_file_path对应的音频文件，将其以 'sample_interval' 为间隔进行切分
%   切割后的音频保存至"E:\Myself\2.database\2.wav_cut\wav_'sample_interval'"路径下
%   打印切分信息
%
% 4)auido_files_num = wav_cut_time(audio_file_path, time_interval, output_files_path, show_info)
%   读取audio_file_path对应的音频文件，将其以 'sample_interval' 为间隔进行切分
%   切割后的音频保存至"E:\Myself\2.database\2.wav_cut\wav_'sample_interval'"路径下
%   根据show_info标识符确认是否打印切分信息

function auido_files_num = wav_cut_sample(audio_file_path, sample_interval, output_files_path, show_info)

% 默认裁剪时长为10秒
if nargin == 1
    sample_interval = 16000;
    output_files_path = 'E:\Myself\2.database\2.wav_cut\wav_16000';
    show_info = 'on';
end

% 默认裁剪保存路径
if nargin == 2
    output_files_path = strcat('E:\Myself\2.database\2.wav_cut\wav_', num2str(sample_interval));
    show_info = 'on';
end

% 默认打印信息
if nargin == 3
    show_info = 'on';
end

audio_file_name = get_file_name(audio_file_path);                               % 音频文件名
[audio_stream, Fs] = audioread(audio_file_path);                                % 读取音频
audio_length = length(audio_stream);                                            % 音频采样点数
fprintf('当前音频文件：%s\n', audio_file_name);                                  % 打印信息
cut_samples = Fs * 10;                                                          % 裁去前后的Fs*10个采样点，避免出现多个连续的0

audio_stream = audio_stream(cut_samples + 1 : audio_length - cut_samples, :);
audio_length = length(audio_stream);
fragments = floor(audio_length / sample_interval);                              % 计算可切分的片段
auido_files_num = fragments;

if fragments < 1
    fprintf('音频文件过短，不能完成切割...\n');
else
    start_location = 1;
    if strcmp(show_info, 'on') == 1
        for i = 1 : fragments
            output_stream = audio_stream(start_location + (i-1) * sample_interval : ...
                start_location + i * sample_interval - 1, :);                   % 输出音频流
            audio_name = strcat(audio_file_name, '_cut_', num2str(i), '.wav');  % 输出音频流文件名
            fprintf('audio %d-th：%s\n', i, audio_name);                        % 打印信息
            output_audio_file_path = fullfile(output_files_path, audio_name);   % 输出音频流路径
            audiowrite(output_audio_file_path, output_stream, Fs);              % 将文件写出
        end
        
    else
        for i = 1 : fragments
            output_stream = audio_stream(start_location + (i-1) * sample_interval: ...
                start_location + i * sample_interval - 1, :);                   % 输出音频流
            audio_name = strcat(audio_file_name, '_cut_', num2str(i), '.wav');  % 输出音频流文件名
            output_audio_file_path = fullfile(output_files_path, audio_name);   % 输出音频流路径
            audiowrite(output_audio_file_path, output_stream, Fs);              % 将文件写出
        end
    end
    
end

fprintf('当前音频总采样点数%ds  裁剪音频采样点数%ds 裁剪音频%d个\n', ...
    audio_length, sample_interval, fragments);
end