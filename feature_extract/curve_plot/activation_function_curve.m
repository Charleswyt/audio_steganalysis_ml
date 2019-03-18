%% a script for activation funtion visualization
% sigmoid, tanh, relu, leaky relu
close all;

x = -10:0.1:10;
alpha = 0.2;

sigmoid = 1 ./ (1 + exp(-x));
tanh = (exp(x) - exp(-x)) ./ (exp(x) + exp(-x));
relu = max(0, x);
leaky_ralu = max(alpha.*x, x);

figure(1);plot(x, sigmoid, 'linewidth', 2);
xlabel('x', 'FontSize', 16);
ylabel('y', 'FontSize', 16);
set(gca,'FontName','Times New Roman','FontSize',14);


figure(2);plot(x, tanh, 'linewidth', 2);
xlabel('x', 'FontSize', 16);
ylabel('y', 'FontSize', 16);
set(gca,'FontName','Times New Roman','FontSize',14);

figure(3);plot(x, relu, 'linewidth', 2);
xlabel('x', 'FontSize', 16);
ylabel('y', 'FontSize', 16);
set(gca,'FontName','Times New Roman','FontSize',14);

figure(4);plot(x, leaky_ralu, 'linewidth', 2);
xlabel('x', 'FontSize', 16);
ylabel('y', 'FontSize', 16);
set(gca,'FontName','Times New Roman','FontSize',14);