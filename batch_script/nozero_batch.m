%% calculate the percent of nonzero value is QMDCT coefficients matrix

W = 6;
bitrate = 320;
file_num = 5;

cover_dir = ['E:\Myself\2.database\10.QMDCT\1.txt\cover\', num2str(bitrate)];
stego_dir = ['E:\Myself\2.database\10.QMDCT\1.txt\EECS\', num2str(bitrate), '_W_' num2str(W), '_H_7_ER_10'];

[cover_files_list, files_num] = get_files_list(cover_dir, 'txt');
[stego_files_list, ~] = get_files_list(stego_dir, 'txt');

if file_num > files_num
    file_num = files_num;
end


[nozero_dif, nozero_dif_row_1, nozero_dif_row_2, nozero_dif_col_1, nozero_dif_col_2] = deal(0, 0, 0, 0, 0);

for i = 1:file_num
    cover_file_path = fullfile(cover_dir, cover_files_list{i});
    stego_file_path = fullfile(stego_dir, stego_files_list{i});
    
    % load the QMDCT coefficients and cut the width to 380
    cover = load(cover_file_path);cover = cover(:, 1:380);
    stego = load(stego_file_path);stego = stego(:, 1:380);

    % difference (cover)
    cover_dif_row_1 = diff(cover, 1, 1);
    cover_dif_row_2 = diff(cover, 2, 1);
    cover_dif_col_1 = diff(cover, 1, 2);
    cover_dif_col_2 = diff(cover, 2, 2);
    
    % difference (stego)
    stego_dif_row_1 = diff(stego, 1, 1);
    stego_dif_row_2 = diff(stego, 2, 1);
    stego_dif_col_1 = diff(stego, 1, 2);
    stego_dif_col_2 = diff(stego, 2, 2);

    % cover -stego
    dif = cover - stego;
    dif_row_1 = cover_dif_row_1 - stego_dif_row_1;
    dif_row_2 = cover_dif_row_2 - stego_dif_row_2;
    dif_col_1 = cover_dif_col_1 - stego_dif_col_1;
    dif_col_2 = cover_dif_col_2 - stego_dif_col_2;

    % get the number of nonzero value
    nozero_dif = nozero_dif + length(find(dif ~= 0)) / length(find(cover ~= 0)) * 100;
    nozero_dif_row_1 = nozero_dif_row_1 + length(find(dif_row_1 ~= 0)) / length(find(cover ~= 0)) * 100;
    nozero_dif_row_2 = nozero_dif_row_2 + length(find(dif_row_2 ~= 0)) / length(find(cover ~= 0)) * 100;
    nozero_dif_col_1 = nozero_dif_col_1 + length(find(dif_col_1 ~= 0)) / length(find(cover ~= 0)) * 100;
    nozero_dif_col_2 = nozero_dif_col_2 + length(find(dif_col_2 ~= 0)) / length(find(cover ~= 0)) * 100;
    
end

format short g;
fprintf('bitrate = %d, W = %d, file num = %d\n', bitrate, W, file_num);
fprintf('original: %.2f\n', nozero_dif / file_num);
fprintf('row_1: %.2f%%\n', nozero_dif_row_1 / file_num);
fprintf('row_2: %.2f%%\n', nozero_dif_row_2 / file_num);
fprintf('col_1: %.2f%%\n', nozero_dif_col_1 / file_num);
fprintf('col_2: %.2f%%\n', nozero_dif_col_2 / file_num);