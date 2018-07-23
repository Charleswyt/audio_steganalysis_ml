%% get distribution of modified QMDCT coefficients
close all;

threshold = 15;
bitrate = [128, 192, 256, 320];
figure(1);

matrix_file_name = 'wav10s_00003.txt';
for i = 1:length(bitrate)
    cover_file_path = fullfile('E:\Myself\2.database\mtap\txt\cover', num2str(bitrate(i)), matrix_file_name);
    stego_file_path = fullfile('E:\Myself\2.database\mtap\txt\stego\EECS', ['EECS_B_', num2str(bitrate(i)), '_W_2_H_7_ER_10'], matrix_file_name);
%     stego_file_path = ['E:\Myself\2.database\mtap\txt\stego\HCM\HCM_B_', num2str(bitrate(i)), '_ER_10\wav10s_00003.txt'];
    
%     cover_file_path = ['E:\Myself\2.database\mtap\mp3\cover\mp3stego_', num2str(bitrate(i)), '\wav10s_00001.txt'];
%     stego_file_path = ['E:\Myself\2.database\mtap\mp3\stego\MP3Stego\MP3Stego_B_', num2str(bitrate(i)), '_ER_10\wav10s_00001.txt'];
    
    cover = load(cover_file_path);
    stego = load(stego_file_path);
    
    diff = cover - stego;
    position = (diff ~= 0);
    
    cover_modified = cover(position);    
    tab_cover = tabulate(cover_modified(:));
    
    plot(tab_cover(:,1), tab_cover(:,3), 'LineWidth', 2);hold on;
end

% label
xlabel('QMDCT Coefficients Value', 'fontsize', 12);
ylabel('Percentage (%)', 'fontsize', 12);
legend('128 kbps','192 kbps','256 kbps','320 kbps');
set(gca,'FontSize',11);
axis([-15, 15, 0, 25]);