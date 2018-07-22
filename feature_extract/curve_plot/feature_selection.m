%% load QMDCT file
QMDCT_cover_file = load('E:\Myself\2.database\mtap\mp3\cover\128\wav10s_00001.txt');
QMDCT_stego_file = load('E:\Myself\2.database\mtap\mp3\stego\EECS\EECS_W_2_B_128_ER_10\wav10s_00001_stego_128.txt');

cover = load(QMDCT_cover_file);
stego = load(QMDCT_stego_file);

%% preprocessing
% matrix_dif_c_1 = pre_process_matrix(matrix, 'dif1_h');
% matrix_dif_r_1 = pre_process_matrix(matrix, 'dif1_v');
% matrix_dif_c_2 = pre_process_matrix(matrix, 'dif2_h');
% matrix_dif_r_2 = pre_process_matrix(matrix, 'dif2_v');

% matrix_abs_dif_c_1 = pre_process_matrix(matrix, 'abs_dif1_h');
% matrix_abs_dif_r_1 = pre_process_matrix(matrix, 'abs_dif1_v');
% matrix_abs_dif_c_2 = pre_process_matrix(matrix, 'abs_dif2_h');
% matrix_abs_dif_r_2 = pre_process_matrix(matrix, 'abs_dif2_v');

%% feature extraction
feature_cover_point = 

dimension = size(A);
mat = A;                                                                    % A n-by-n matrix of random values from 0 to 1
imagesc(mat);                                                               % Create a colored plot of the matrix values
colormap(flipud(gray));                                                     % Change the colormap to gray (so higher values are

set(gca, ...
    'XTick',1:11,...                                                        % Change the axes tick marks
    'XTickLabel',{'-5', '-4', '-3','-2','-1','0','1','2','3','4','5'},...   % and tick labels
    'YTick',1:11,...
    'YTickLabel',{'-5', '-4', '-3','-2','-1','0','1','2','3','4','5'},...
    'TickLength',[0 0]);
xlabel('Q_{ij}', 'FontSize', 12);
ylabel('Q_{ij}', 'FontSize', 12);
[x,y] = meshgrid(1:dimension);                                              % Create x and y coordinates for the strings
midValue = mean(get(gca,'CLim'));                                           % Get the middle value of the color range
textColors = repmat(mat(:) > midValue,1,3);                                 % Choose white or black for the