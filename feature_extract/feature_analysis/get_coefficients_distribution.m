%% get distribution of QMDCT coefficients
close all;

threshold = 15;
bitrate = [128, 192, 256, 320];
figure(1);
for i = 1:length(bitrate)
    matrix_file_path = ['E:\Myself\2.database\mtap\txt\cover\', num2str(bitrate(i)), '\wav10s_00001.txt'];
    matrix = load(matrix_file_path);
    matrix_tab = tabulate(matrix(:));
    remove_row = find(abs(matrix_tab(:,1)) > threshold);
    matrix_tab(remove_row,:) = [];
    plot(matrix_tab(:,1), matrix_tab(:,3), 'LineWidth', 2);hold on;
end
xlabel('QMDCT Coefficients Value', 'fontsize', 12);
ylabel('Percentage(%)', 'fontsize', 12);
legend('128 kbps','192 kbps','256 kbps','320 kbps');
set(gca,'FontSize',11);
axis([min(matrix_tab(:,1)), max(matrix_tab(:,1)), 0, 80]);