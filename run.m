% feature_cover_128_jin = load('E:\Myself\2.database\data_1000\feature_mat\cover\jin\128');
% feature_stego_128_jin_01 = load('E:\Myself\2.database\data_1000\feature_mat\stego\HCM\jin\HCM_B_128_ER_01');
% feature_stego_128_jin_03 = load('E:\Myself\2.database\data_1000\feature_mat\stego\HCM\jin\HCM_B_128_ER_03');
% feature_stego_128_jin_05 = load('E:\Myself\2.database\data_1000\feature_mat\stego\HCM\jin\HCM_B_128_ER_05');
% 
% feature_cover_320_jin = load('E:\Myself\2.database\data_1000\feature_mat\cover\jin\320');
% feature_stego_320_jin_01 = load('E:\Myself\2.database\data_1000\feature_mat\stego\HCM\jin\HCM_B_320_ER_01');
% feature_stego_320_jin_03 = load('E:\Myself\2.database\data_1000\feature_mat\stego\HCM\jin\HCM_B_320_ER_03');
% feature_stego_320_jin_05 = load('E:\Myself\2.database\data_1000\feature_mat\stego\HCM\jin\HCM_B_320_ER_05');
%  
% feature_cover_128_jin = feature_cover_128_jin.features;
% feature_cover_320_jin = feature_cover_320_jin.features;
% feature_stego_128_jin_01 = feature_stego_128_jin_01.features;
% feature_stego_128_jin_03 = feature_stego_128_jin_03.features;
% feature_stego_128_jin_05 = feature_stego_128_jin_05.features;
% 
% feature_stego_320_jin_01 = feature_stego_320_jin_01.features;
% feature_stego_320_jin_03 = feature_stego_320_jin_03.features;
% feature_stego_320_jin_05 = feature_stego_320_jin_05.features;

ACC = 0;
number = 10;
for i = 1:number
    result = training(feature_cover_128_jin, feature_stego_128_jin_01, 0.6);
    ACC = ACC + result.ACC;
end

fprintf('Average accuracy: %.2f%%\n', ACC / number * 100);

