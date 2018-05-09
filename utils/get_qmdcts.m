%% get QMDCT coefficients of audio file
% - QMDCT = get_qmdcts(audio_file_path, frame_num, coeff_num)
% - Variable:
% ------------------------------------------input
% audio_file_path       the path of audio file
% frame_num             the number of frame, default is 50
% coeff_num             the number of QMDCT coefficients in a row, default is 576
% -----------------------------------------output
% QMDCT                 QMDCT matrix

function QMDCT = get_qmdcts(audio_file_path, frame_num, coeff_num)

% default
if ~exist('frame_num', 'var') || isempty(frame_num)
    frame_num = 50;
end

if ~exist('coeff_num', 'var') || isempty(coeff_num)
    coeff_num = 576;
end

path_length = length(audio_file_path);
wav_file_path = strcat(audio_file_path(1:path_length - 3), 'wav');
txt_file_path = strcat(audio_file_path(1:path_length - 3), 'txt');
command = ['lame_qmdct.exe', ' ', audio_file_path, ' ', ' -stratind 0', ' ', '-framenum ', str(frame_num), ' ', '-coeffnum 576 --decode'];
system(command);

QMDCT = load(txt_file_path);
command_del = ['del', ' ', wav_file_path, ' ', txt_file_path];
system(command_del);

QMDCT = QMDCT(1:4*frame_num, coeff_num);