%% plot the distribution histogram of QMDCT coefficient value
close all;

T = 15;
bitrates = [128, 192, 256, 320];
for bitrate = bitrates
    matrix_file_path = strcat('E:\Myself\2.database\3.cover\cover_10s_new\', num2str(bitrate), '\wav10s_00001.txt');
    matrix = load(matrix_file_path);
    distribution = tabulate(matrix(:));

    % remove the values out of [-T, T]
    row_left = find(distribution(:,1) == -T);
    row_right = find(distribution(:,1) == T);
    distribution([1:row_left-1,row_right+1:end], :) = [];

    figure(1);
    plot(distribution(:,1), distribution(:,3), 'linewidth', 2);
    xlabel('QMDCT coefficient value', 'FontSize', 12);
    ylabel('Percent (%)', 'FontSize', 13);
    set(gca,'xtick',-T:3:T);
    set(gca,'xticklabel',{'-15' '-12' '-9' '-6' '-3' '0' '3' '6' '9', '12', '15'});
    hold on;
end
figure_legend = legend('128 kbps', '192 kbps', '256 kbps', '320 kbps');
set(figure_legend, 'FontSize', 10);

% remove the value of zero
% zero = find(distribution(:, 1) == 0);
% distribution(zero, :) = [];

% figure(2);
% plot(distribution(:,1), distribution(:,3));
% xlabel('QMDCT coefficients value', 'FontSize', 13);
% ylabel('Percent (%)', 'FontSize', 13);
% set(gca,'xtick',-T:3:T);
% set(gca,'xticklabel',{'-15' '-12' '-9' '-6' '-3' '0' '3' '6' '9', '12', '15'});