%% plot the distribution histogram of QMDCT coefficient value
T = 15;
matrix_file_path = 'E:\Myself\2.database\10.QMDCT\1.txt\cover\128\wav10s_00001.txt';
matrix = load(matrix_file_path);
distribution = tabulate(matrix(:));

% remove the values out of [-T, T]
row_left = find(distribution(:,1) == -T);
row_right = find(distribution(:,1) == T);
distribution([1:row_left-1,row_right+1:end], :) = [];

figure(1);
bar(distribution(:,1), distribution(:,3));
xlabel('QMDCT coefficient value', 'FontSize', 13);
ylabel('Percent (%)', 'FontSize', 13);
set(gca,'xtick',-T:3:T);
set(gca,'xticklabel',{'-15' '-12' '-9' '-6' '-3' '0' '3' '6' '9', '12', '15'});

% remove the value of zero
zero = find(distribution(:, 1) == 0);
distribution(zero, :) = [];

figure(2);
bar(distribution(:,1), distribution(:,3));
xlabel('QMDCT coefficients value', 'FontSize', 13);
ylabel('Percent (%)', 'FontSize', 13);
set(gca,'xtick',-T:3:T);
set(gca,'xticklabel',{'-15' '-12' '-9' '-6' '-3' '0' '3' '6' '9', '12', '15'});