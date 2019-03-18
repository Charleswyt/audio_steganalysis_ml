cover_files_dir = 'E:\Myself\2.database\10.QMDCT\cover\cover_10s\128\train';
stego_files_dir = 'E:\Myself\2.database\10.QMDCT\stego\EECS\EECS_B_128_W_5_H_7_ER_10\train';

[files_list, file_num] = get_files_list(cover_files_dir, 'txt');
for i = 1:file_num
    cover_file_path = fullfile(cover_files_dir, files_list{i});
    stego_file_path = fullfile(stego_files_dir, files_list{i});
    cover = load(cover_file_path);
    stego = load(stego_file_path);
    dif = cover(:,1:450) - stego(:,1:450);
    percentage = length(find(dif~=0)) / (200 * 450);
    fprintf('file-%d, %.2f%%\n', i, 100 * percentage);
end
    