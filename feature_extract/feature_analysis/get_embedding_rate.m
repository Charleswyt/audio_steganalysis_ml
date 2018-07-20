%% get embedding rate

% signal file check
% audio_file_name = 'wav10s_00018.mp3';
% cover_audio_files_path = 'E:\Myself\2.database\mtap\mp3\cover\MP3Stego_320';
% stego_audio_files_path = 'E:\Myself\2.database\mtap\mp3\stego\MP3Stego\MP3Stego_B_320_ER_10';
% cover_audio_path = fullfile(cover_audio_files_path, audio_file_name);
% stego_audio_path = fullfile(stego_audio_files_path, audio_file_name);
% 
% embedding_rate_check(cover_audio_path, stego_audio_path);

% multi file chek
bitrate = [128, 192, 256, 320];
stego_method = {'MP3Stego', 'HCM', 'EECS'};
embedding_rate = [3, 5, 8, 10];
cover_dir = 'E:\Myself\2.database\mtap\mp3\cover';
stego_dir = 'E:\Myself\2.database\mtap\mp3\stego';

for s = 1:length(stego_method)
    for b = 1:length(bitrate)
        for e = 1:length(embedding_rate)
            if strcmp(stego_method{s}, 'MP3Stego')
                if embedding_rate(e) == 10
                    stego_files_name = ['MP3Stego_B_', num2str(bitrate(b)), '_ER_', num2str(embedding_rate(e))];
                else
                    stego_files_name = ['MP3Stego_B_', num2str(bitrate(b)), '_ER_0', num2str(embedding_rate(e))];
                end
                cover_audio_file_name = 'wav10s_00001.mp3';
                stego_audio_file_name = 'wav10s_00001.mp3';
                cover_audio_files_path = fullfile(cover_dir, ['MP3Stego_', num2str(bitrate(b))]);
                stego_audio_files_path = fullfile(stego_dir, 'MP3Stego', stego_files_name);
            elseif strcmp(stego_method{s}, 'HCM')
                if embedding_rate(e) == 10
                    stego_files_name = ['HCM_B_', num2str(bitrate(b)), '_ER_', num2str(embedding_rate(e))];
                else
                    stego_files_name = ['HCM_B_', num2str(bitrate(b)), '_ER_0', num2str(embedding_rate(e))];
                end
                cover_audio_file_name = 'wav10s_00001.mp3';
                stego_audio_file_name = 'wav10s_00001.mp3';
                cover_audio_files_path = fullfile(cover_dir, num2str(bitrate(b)));
                stego_audio_files_path = fullfile(stego_dir, 'HCM', stego_files_name);
            else
                audio_file_name = 'wav10s_00001.mp3';
                stego_audio_file_name = ['wav10s_00001_stego_', num2str(bitrate(b)), '.mp3'];
                if embedding_rate(e) == 10
                    stego_files_name = ['EECS_W_2_B_', num2str(bitrate(b)), '_ER_', num2str(embedding_rate(e))];
                else
                    stego_files_name = ['EECS_W_2_B_', num2str(bitrate(b)), '_ER_0', num2str(embedding_rate(e))];
                end
                cover_audio_files_path = fullfile(cover_dir, num2str(bitrate(b)));
                stego_audio_files_path = fullfile(stego_dir, 'EECS', stego_files_name);
            end
            cover_audio_path = fullfile(cover_audio_files_path, cover_audio_file_name);
            stego_audio_path = fullfile(stego_audio_files_path, stego_audio_file_name);
            fprintf('%s:\n', stego_files_name);
            embedding_rate_check(cover_audio_path, stego_audio_path);
        end
    end
end