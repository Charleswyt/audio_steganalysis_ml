close all;

T = [3,4,5,6,7,8,9,10];

%% MP3Stego
ACC_MP3Stego_128 = [94.80, 93.57, 93.29, 92.15, 91.15, 89.89, 87.42, 86.55];
ACC_MP3Stego_192 = [96.45, 96.50, 96.42, 95.84, 95.17, 94.24, 93.92, 91.65];
ACC_MP3Stego_256 = [97.58, 98.00, 97.52, 96.92, 96.25, 96.19, 96.08, 94.02];
ACC_MP3Stego_320 = [98.31, 98.32, 98.40, 98.31, 97.87, 97.08, 96.97, 96.52];


%% HCM
ACC_HCM_128 = [92.98, 92.58, 92.35, 91.83, 90.54, 89.75, 89.08, 84.18];
ACC_HCM_192 = [96.76, 97.65, 97.67, 97.81, 96.77, 95.59, 94.56, 93.06];
ACC_HCM_256 = [98.08, 98.33, 98.66, 98.14, 97.67, 96.58, 95.46, 94.14];
ACC_HCM_320 = [99.17, 99.66, 99.84, 99.50, 99.44, 99.32, 99.13, 98.92];

%% EECS
ACC_EECS_128 = [73.02, 72.85, 70.67, 69.54, 67.30, 63.25, 56.54, 56.12];
ACC_EECS_192 = [75.26, 75.75, 74.97, 73.12, 71.01, 67.24, 65.42, 63.60];
ACC_EECS_256 = [80.11, 81.30, 82.63, 80.76, 78.92, 75.35, 73.66, 71.75];
ACC_EECS_320 = [85.61, 85.67, 86.23, 85.12, 84.93, 84.50, 83.27, 80.37];

figure(1);
plot(T, ACC_MP3Stego_128, '-o', 'linewidth', 2, 'MarkerSize', 5);hold on;
plot(T, ACC_MP3Stego_192, '-s', 'linewidth', 2, 'MarkerSize', 5);hold on;
plot(T, ACC_MP3Stego_256, '-d', 'linewidth', 2, 'MarkerSize', 5);hold on;
plot(T, ACC_MP3Stego_320, '-*', 'linewidth', 2, 'MarkerSize', 5);hold on;
xlabel('Threshold T', 'FontSize', 12);
ylabel('Accuracy (%)', 'FontSize', 12);
legend('128 kbps', '192 kbps', '256 kbps', '320 kbps', 'Location', 'SouthWest');

figure(2);
plot(T, ACC_HCM_128, '-o', 'linewidth', 2, 'MarkerSize', 5);hold on;
plot(T, ACC_HCM_192, '-s', 'linewidth', 2, 'MarkerSize', 5);hold on;
plot(T, ACC_HCM_256, '-d', 'linewidth', 2, 'MarkerSize', 5);hold on;
plot(T, ACC_HCM_320, '-*', 'linewidth', 2, 'MarkerSize', 5);hold on;
xlabel('Threshold T', 'FontSize', 12);
ylabel('Accuracy (%)', 'FontSize', 12);
legend('128 kbps', '192 kbps', '256 kbps', '320 kbps', 'Location', 'SouthWest');

figure(3);
plot(T, ACC_EECS_128, '-o', 'linewidth', 2, 'MarkerSize', 5);hold on;
plot(T, ACC_EECS_192, '-s', 'linewidth', 2, 'MarkerSize', 5);hold on;
plot(T, ACC_EECS_256, '-d', 'linewidth', 2, 'MarkerSize', 5);hold on;
plot(T, ACC_EECS_320, '-*', 'linewidth', 2, 'MarkerSize', 5);hold on;
xlabel('Threshold T', 'FontSize', 12);
ylabel('Accuracy (%)', 'FontSize', 12);
legend('128 kbps', '192 kbps', '256 kbps', '320 kbps', 'Location', 'SouthWest');