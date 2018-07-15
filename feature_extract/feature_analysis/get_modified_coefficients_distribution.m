%% get distribution of modified QMDCT coefficients
close all;

threshold = 15;
bitrate = [128, 192, 256, 320];
figure(1);
for i = 1:length(bitrate)
%     cover_file_path = ['E:\Myself\2.database\mtap\txt\cover\', num2str(bitrate(i)), '\wav10s_00003.txt'];
%     stego_file_path = ['E:\Myself\2.database\mtap\txt\stego\EECS\EECS_W_2_B_', num2str(bitrate(i)), '_ER_10\wav10s_00003_stego_', num2str(bitrate(i)), '.txt'];
%     stego_file_path = ['E:\Myself\2.database\mtap\txt\stego\HCM\HCM_B_', num2str(bitrate(i)), '_ER_10\wav10s_00003.txt'];
    
    cover_file_path = ['E:\Myself\2.database\mtap\mp3\cover\mp3stego_', num2str(bitrate(i)), '\wav10s_00001.txt'];
    stego_file_path = ['E:\Myself\2.database\mtap\mp3\stego\MP3Stego\MP3Stego_B_', num2str(bitrate(i)), '_ER_10\wav10s_00001.txt'];
    
    cover = load(cover_file_path);
    stego = load(stego_file_path);
    
    diff = cover - stego;
    position = (diff ~= 0);
    
    cover_modified = cover(position);
    stego_modified = stego(position);
    
    tab_cover = tabulate(cover_modified(:));
    tab_stego = tabulate(stego_modified(:));
    
    plot(tab_cover(:,1), tab_cover(:,3), 'LineWidth', 2);hold on;
end
xlabel('QMDCT Coefficients Value', 'fontsize', 12);
ylabel('Percentage (%)', 'fontsize', 12);
legend('128 kbps','192 kbps','256 kbps','320 kbps');
set(gca,'FontSize',11);
axis([min(matrix_tab(:,1)), max(matrix_tab(:,1)), 0, 40]);