%% Get difference percentage (used to select a better preprocessing method)
% difference_percentage(cover_qmdct_file_path, stego_qmdct_file_path)
% - Variable:
% ------------------------------------------input
% cover_qmdct_file_path           path of cover qmdct file
% stego_qmdct_file_path           path of stego qmdct file
% -----------------------------------------output
% NULL

function difference_percentage(cover_qmdct_file_path, stego_qmdct_file_path)

cover = load(cover_qmdct_file_path);
stego = load(stego_qmdct_file_path);

%% cut
QMDCT_num = 420;
cover = cover(:, 1:QMDCT_num);
stego = stego(:, 1:QMDCT_num);

%% prepcrocessing
% cover
cover_abs = pre_process_matrix(cover, 'abs');

cover_dif_c_1 = pre_process_matrix(cover, 'dif1_h');
cover_dif_r_1 = pre_process_matrix(cover, 'dif1_v');
cover_dif_c_2 = pre_process_matrix(cover, 'dif2_h');
cover_dif_r_2 = pre_process_matrix(cover, 'dif2_v');

cover_abs_dif_c_1 = pre_process_matrix(cover, 'abs_dif1_h');
cover_abs_dif_r_1 = pre_process_matrix(cover, 'abs_dif1_v');
cover_abs_dif_c_2 = pre_process_matrix(cover, 'abs_dif2_h');
cover_abs_dif_r_2 = pre_process_matrix(cover, 'abs_dif2_v');

% stego
stego_abs = pre_process_matrix(stego, 'abs');

stego_dif_c_1 = pre_process_matrix(stego, 'dif1_h');
stego_dif_r_1 = pre_process_matrix(stego, 'dif1_v');
stego_dif_c_2 = pre_process_matrix(stego, 'dif2_h');
stego_dif_r_2 = pre_process_matrix(stego, 'dif2_v');

stego_abs_dif_c_1 = pre_process_matrix(stego, 'abs_dif1_h');
stego_abs_dif_r_1 = pre_process_matrix(stego, 'abs_dif1_v');
stego_abs_dif_c_2 = pre_process_matrix(stego, 'abs_dif2_h');
stego_abs_dif_r_2 = pre_process_matrix(stego, 'abs_dif2_v');

% substraction
diff = cover(:) - stego(:);percentage = length(find(diff ~= 0)) / length(cover(:));
diff_abs = cover_abs(:) - stego_abs(:);percentage_abs = length(find(diff_abs ~= 0)) / length(cover(:));

diff_dif_c_1 = cover_dif_c_1(:) - stego_dif_c_1(:);percentage_dif_c_1 = length(find(diff_dif_c_1 ~= 0)) / length(cover(:));
diff_dif_r_1 = cover_dif_r_1(:) - stego_dif_r_1(:);percentage_dif_r_1 = length(find(diff_dif_r_1 ~= 0)) / length(cover(:));
diff_dif_c_2 = cover_dif_c_2(:) - stego_dif_c_2(:);percentage_dif_c_2 = length(find(diff_dif_c_2 ~= 0)) / length(cover(:));
diff_dif_r_2 = cover_dif_r_2(:) - stego_dif_r_2(:);percentage_dif_r_2 = length(find(diff_dif_r_2 ~= 0)) / length(cover(:));

diff_abs_dif_c_1 = cover_abs_dif_c_1(:) - stego_abs_dif_c_1(:);percentage_abs_dif_c_1 = length(find(diff_abs_dif_c_1 ~= 0)) / length(cover(:));
diff_abs_dif_r_1 = cover_abs_dif_r_1(:) - stego_abs_dif_r_1(:);percentage_abs_dif_r_1 = length(find(diff_abs_dif_r_1 ~= 0)) / length(cover(:));
diff_abs_dif_c_2 = cover_abs_dif_c_2(:) - stego_abs_dif_c_2(:);percentage_abs_dif_c_2 = length(find(diff_abs_dif_c_2 ~= 0)) / length(cover(:));
diff_abs_dif_r_2 = cover_abs_dif_r_2(:) - stego_abs_dif_r_2(:);percentage_abs_dif_r_2 = length(find(diff_abs_dif_r_2 ~= 0)) / length(cover(:));

fprintf('==================================\n');
fprintf('original: %.2f%%\n', percentage*100);
fprintf('absolute: %.2f%%\n', percentage_abs*100);

fprintf('first  order col difference: %.2f%%\n', percentage_dif_c_1*100);
fprintf('first  order row difference: %.2f%%\n', percentage_dif_r_1*100);
fprintf('second order col difference: %.2f%%\n', percentage_dif_c_2*100);
fprintf('second order row difference: %.2f%%\n', percentage_dif_r_2*100);

fprintf('first  order abs col difference: %.2f%%\n', percentage_abs_dif_c_1*100);
fprintf('first  order abs row difference: %.2f%%\n', percentage_abs_dif_r_1*100);
fprintf('second order abs col difference: %.2f%%\n', percentage_abs_dif_c_2*100);
fprintf('second order abs row difference: %.2f%%\n', percentage_abs_dif_r_2*100);