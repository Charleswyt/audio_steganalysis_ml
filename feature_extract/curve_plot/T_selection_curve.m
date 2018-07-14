T = [3,4,5,6,7,8,9,10];
Acc = [90.94,88.84,90.24,88.78,87.92,86.38,85.98,84.77];

plot(T, Acc, '-*', 'linewidth', 2, 'markersize', 5);
xlabel('Threshold T', 'FontSize', 12);
ylabel('Accuracy (%)', 'FontSize', 12);

legend('EECS');