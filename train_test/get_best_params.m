%% Get the best parameters of
% - [best_acc, best_t, best_c, best_g] = 
%               ...get_best_params(cover_feature, stego_feature, t_flag, c_value, g_value, num_folder, c_step, g_step)
% - Variable:
%------------------------------------------input
% cover_feature         the feature of cover samples
% stego_feature         the feature of stego samples
% t_flag                a flag which indicates whether find best t or not, default is "False" -> t=0 (linear kernel)
% c_value               c_min = -c_value, c_max = c_value
% g_value               g_min = -g_value, g_max = g_value
% c_step                step of c value
% g_step                step of g value
%-----------------------------------------output
% best_acc              accuracy with best parameters
% best_t                best t value
% best_c               	best c value
% best_g                best g value


function [best_acc, best_t, best_c, best_g] = get_best_params(cover_feature,stego_feature, t_flag, c_value, g_value, num_folder, c_step, g_step)

if ~exist('t_flag', 'var') || isempty(t_flag) t_flag = 'False'; end         %#ok<SEPEX>
if ~exist('c_value', 'var') || isempty(c_value) c_value = 10; end           %#ok<SEPEX>
if ~exist('g_value', 'var') || isempty(g_value) g_value = 5; end            %#ok<SEPEX>
if ~exist('num_folder', 'var') || isempty(num_folder) num_folder = 10; end  %#ok<SEPEX>
if ~exist('c_step', 'var') || isempty(c_step) c_step = 1; end               %#ok<SEPEX>
if ~exist('g_step', 'var') || isempty(g_step) g_step = 1; end               %#ok<SEPEX>
if ~exist('t_flag', 'var') || isempty(t_flag) t_flag = 'False'; end         %#ok<SEPEX>

feature = [cover_feature;stego_feature];
cover_label = zeros(size(cover_feature,1),1);
stego_label = ones(size(stego_feature,1),1);
label = [cover_label;stego_label];

[best_acc, best_t, best_c, best_g] = SVM(label, feature, t_flag, -c_value, c_value, -g_value, g_value, num_folder, c_step, g_step);