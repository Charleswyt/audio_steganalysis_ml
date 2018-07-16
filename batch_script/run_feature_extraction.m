%% feature extraction

width = [2, 3];
bitrate = [128, 192, 256, 320];
embeding_rate = [1, 3, 5, 8, 10];
stego_method = {'EECS', 'HCM'};
feature_type = {'jin', 'ren', 'wang'};

QMDCT_num = 500;
text_nums = 1000;

data_cover_mat_dir = 'E:\Myself\2.database\mtap\data_mat\cover';
data_stego_mat_dir = 'E:\Myself\2.database\mtap\data_mat\stego';

for f = 1:length(feature_type)
    
            
            