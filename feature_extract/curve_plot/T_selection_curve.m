close all;

T = [3,4,5,6,7,8,9,10];
Acc_HCM = [71.08, 69.77, 69.64, 68.72, 67.16, 63.90, 57.82, 57.48];
ACC_EECS = [93.11, 92.80, 92.63, 91.76, 91.58, 89.35, 87.66, 85.60];

plot(T, Acc_HCM,  '-*', 'linewidth', 2, 'markersize', 5);hold on;
plot(T, ACC_EECS, '-o', 'linewidth', 2, 'markersize', 5);

xlabel('Threshold T', 'FontSize', 12);
ylabel('Accuracy (%)', 'FontSize', 12);

legend('HCM', 'EECS');