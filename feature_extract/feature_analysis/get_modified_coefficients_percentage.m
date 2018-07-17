%% get percentage of modified QMDCT coefficients in the range of [-T, T]
close all;

threshold = [3,4,5,6,7,8,9,10];
bitrate = [128, 192, 256, 320];
percentages = zeros(1, 4);

for T = threshold
    fprintf('T = %d\n', T);
    for i = 1:length(bitrate)
        cover_file_path = ['E:\Myself\2.database\mtap\txt\cover\', num2str(bitrate(i)), '\wav10s_00003.txt'];
        stego_file_path = ['E:\Myself\2.database\mtap\txt\stego\EECS\EECS_W_2_B_', num2str(bitrate(i)), '_ER_10\wav10s_00003_stego_', num2str(bitrate(i)), '.txt'];
    %     stego_file_path = ['E:\Myself\2.database\mtap\txt\stego\HCM\HCM_B_', num2str(bitrate(i)), '_ER_10\wav10s_00003.txt'];

    %     cover_file_path = ['E:\Myself\2.database\mtap\mp3\cover\mp3stego_', num2str(bitrate(i)), '\wav10s_00001.txt'];
    %     stego_file_path = ['E:\Myself\2.database\mtap\mp3\stego\MP3Stego\MP3Stego_B_', num2str(bitrate(i)), '_ER_10\wav10s_00001.txt'];

        cover = load(cover_file_path);
        stego = load(stego_file_path);

        diff = cover - stego;
        position = (diff ~= 0);

        cover_modified = cover(position);    
        tab_cover = tabulate(cover_modified(:));

        tab_cover_x = tab_cover(:,1);
        tab_cover_y = tab_cover(:,3);

        temp = tab_cover_y(abs(tab_cover_x)<=T);
        percentages(i) = sum(temp);
        fprintf('bitrate: %d: percentage = %.2f\n', bitrate(i), percentages(i));
    end
    fprintf('============================\n');
end