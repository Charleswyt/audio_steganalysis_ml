%% get distribution of modified QMDCT coefficients
close all;

threshold = 10;
file_num = 100;
bitrate = [128, 320];
% bitrate = [128, 192, 256, 320];

figure(1);
matrix_file_name = 'wav10s_00003.txt';
for i = 1:length(bitrate)
    cover_files_dir = ['E:\Myself\2.database\data_1000\txt\cover\', num2str(bitrate(i))];
    stego_files_dir = ['E:\Myself\2.database\data_1000\txt\stego\EECS\EECS_B_', num2str(bitrate(i)), '_W_4_H_7_ER_10'];
    cover_files_list = get_files_list(cover_files_dir, 'txt');
    stego_files_list = get_files_list(stego_files_dir, 'txt');
    tab_cover_sum = 0;
    
    for f = 1:file_num
        cover_file_path = fullfile(cover_files_dir, cover_files_list{f});
        stego_file_path = fullfile(stego_files_dir, stego_files_list{f});
        cover = load(cover_file_path);
        stego = load(stego_file_path);

        diff = cover - stego;
        position = (diff ~= 0);
        cover_modified = cover(position);
        tab_cover = tabulate(cover_modified(:));
        remove_row = find(abs(tab_cover(:,1)) > 11);
        tab_cover(remove_row,:) = [];
        
        tab_cover_sum = tab_cover_sum + tab_cover;
    end
    plot(tab_cover_sum(:,1) / file_num, tab_cover_sum(:,3) / file_num, 'LineWidth', 2);hold on;
end

% label
xlabel('QMDCT Coefficients Value', 'fontsize', 12);
ylabel('Percentage (%)', 'fontsize', 12);
legend('128 kbps', '320 kbps');
% legend('128 kbps', '192 kbps', '256 kbps', '320 kbps');
set(gca,'FontSize',11);
axis([-12, 12, 0, 25]);