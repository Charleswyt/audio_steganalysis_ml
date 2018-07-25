% bitrate analysis in frequency domain

close all;

bitrate = [128, 192, 256, 320];
matrix_file_name = 'wav10s_00001.txt';
cover_matrix_dir = 'E:\Myself\2.database\mtap\txt\cover';
stego_matrix_dir = 'E:\Myself\2.database\mtap\txt\stego\EECS';

for b = 1:length(bitrate)
    cover_matrix_path = fullfile(cover_matrix_dir, num2str(bitrate(b)), matrix_file_name);
    stego_matrix_path = fullfile(stego_matrix_dir, ['EECS_B_', num2str(bitrate(b)), '_W_2_H_7_ER_10'], matrix_file_name);
    cover_matrix = load(cover_matrix_path);
    stego_matrix = load(stego_matrix_path);
    matrix_dif = cover_matrix - stego_matrix;
    figure(b);imshow(matrix_dif);
    title(['Bitrate = ', num2str(bitrate(b)), ' kbps']);xlabel('QMDCT Coeffieints');ylabel('Channels');
    axis tight; 
    percentage = length(matrix_dif(matrix_dif ~= 0)) / length(cover_matrix(:));
    fprintf('bitrate: %d, percentage: %.2f\n', bitrate(b), 100 * percentage);
end