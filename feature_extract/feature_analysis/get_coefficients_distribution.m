%% get distribution of QMDCT coefficients
close all;

threshold = 15;
file_num = 100;
bitrate = [128, 320];
% bitrate = [128, 192, 256, 320];

figure(1);
for i = 1:length(bitrate)
    matrix_files_dir = ['E:\Myself\2.database\data_1000\txt\cover\', num2str(bitrate(i))];
    matrix_files_list = get_files_list(matrix_files_dir, 'txt');
    matrix_tab_sum = 0;
    for f = 1:file_num
        matrix_file_path = fullfile(matrix_files_dir, matrix_files_list{f});
        matrix = load(matrix_file_path);
        matrix_tab = tabulate(matrix(:));
        remove_row = find(abs(matrix_tab(:,1)) > threshold);
        matrix_tab(remove_row,:) = [];
        matrix_tab_sum = matrix_tab_sum + matrix_tab;
    end
    plot(matrix_tab_sum(:,1) / file_num, matrix_tab_sum(:,3) / file_num, 'LineWidth', 2);hold on;
end

xlabel('QMDCT Coefficients Value', 'fontsize', 12);
ylabel('Percentage(%)', 'fontsize', 12);
legend('128 kbps', '320 kbps');
% legend('128 kbps', '192 kbps', '256 kbps', '320 kbps');
set(gca,'FontSize',11);
axis([min(matrix_tab(:,1)), max(matrix_tab(:,1)), 0, 80]);