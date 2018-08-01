%% feature selection
% - checkerboard_plot(matrix, side)
% - Variables:
% ------------------------------------------input
% matrix            input data
% side              side length of checkboard
% title_name        title of checkerboard figure
% -----------------------------------------output
% Null

function checkerboard_plot(matrix, side, title_name)

if ~exist('side', 'var') || isempty(side)
    shape = size(matrix);
    side = shape(1);
end

imagesc(matrix);                                                            % Create a colored plot of the matrix values
colormap(flipud(gray));                                                     % Change the colormap to gray (so higher values are

T = (side - 1) / 2;

for t = -T:T
    scale{t+T+1} = num2str(t);                                              %#ok<AGROW>
end

set(gca, ...
    'XTick',1:side,...                                                      % Change the axes tick marks
    'XTickLabel',scale,...                                                  % and tick labels
    'YTick',1:side,...
    'YTickLabel',scale,...
    'TickLength',[0 0]);
xlabel('Q_{ij}', 'FontSize', 12);
ylabel('Q_{ij}', 'FontSize', 12);
title(title_name);