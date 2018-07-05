% Get the best SVM parameters
% [bestacc, best_t, best_c, best_g] = ...
%       SVMcg(train_label, train, t_flag, c_min, c_max, g_min, g_max, v, c_step, g_step)
%
% - Variable:
% ------------------------------------------input
% train_label: train label
% train :train data
% t_flag: a flag which indicates whether find best t or not, default is "False" -> t=0 (linear kernel)
% cmin  : the min poser of c, c_min = 2^(cmin), default is -10
% cmax  : the max poser of c, c_max = 2^(cmax), default is +10
% gmin  : the min poser of g, g_min = 2^(gmin), default is -5
% gmax  : the max poser of g, g_max = 2^(gmax), default is +5
% v     : the folder of cross validation, default is 3
% c_step: the step of c, default is 1
% g_step: the step of g, default is 1
% -----------------------------------------output
% best_t: the best t
% best_c: the best c
% best_g: the best g

%% Description of SVM parameters
% Key         Description                                                Value
%  s    the type of svm,default is 0                0:C-SVC, 1:nu-SVC, 2:one-class-SVM 3:e-SVR 4: nu-SVR
%  t    the type of kernel, default is 0            0:linear,1:poly, 2:RBF, 3:sigmoid
%  d    the degree of kernel, default is 3
%  g    the gamma of kernel, default is 1/k, k is the number of classfication
%  r    coef0, default is 0                 
%  n    nu, the parameter of nu-SVC,e-SVR
%               and nu-SVR,default is 0.5
%  p    the loss function of e-SVR, default is 0.1
%  m    cachesize, the size of cache, unit is 'MB', dafault is 40
%  e    error, default is 0.001
%  h    shringking, default is 1                    0:False, 1:True
%  b    probability estimation, default is 0        0:False, 1:True
%  wi   the weight of c, default is 1

function [best_acc, best_t, best_c, best_g] = ...
    SVM(label, data, t_flag, c_min, c_max, g_min, g_max, v, c_step, g_step)

%% default
if ~exist('v', 'var') || isempty(v) v = 10; end                             %#ok<SEPEX>
if ~exist('g_max', 'var') || isempty(g_max) g_max = 5; end                  %#ok<SEPEX>
if ~exist('c_max', 'var') || isempty(c_max) c_max = 5; end                  %#ok<SEPEX>
if ~exist('g_min', 'var') || isempty(g_min) g_min = -5; end                 %#ok<SEPEX>
if ~exist('c_min', 'var') || isempty(c_min) c_min = -5; end                 %#ok<SEPEX>
if ~exist('c_step', 'var') || isempty(c_step) c_step = 1; end               %#ok<SEPEX>
if ~exist('g_step', 'var') || isempty(g_step) g_step = 1; end               %#ok<SEPEX>
if ~exist('t_flag', 'var') || isempty(t_flag) t_flag = 'False'; end         %#ok<SEPEX>

%% X:c Y:g cg:acc
[X, Y] = meshgrid(c_min:c_step:c_max, g_min:g_step:g_max);
[m, n] = size(X);
if strcmp(t_flag, 'True') T = [0, 2]; end                                   %#ok<SEPEX>
if strcmp(t_flag, 'False') T = 0; end                                       %#ok<SEPEX>

%% record acc with different c & g,and find the best acc with the smallest c
[best_c, best_g, best_acc, base_num] = deal(0, 0, 0, 2);
for t = T
    for i = 1:m
        for j = 1:n
            svm_params = ['-s 0 -t ',num2str(t),' -v ',num2str(v),' -c ',num2str(base_num^X(i,j)),' -g ',num2str(base_num^Y(i,j))];
            cg(t+1,i,j) = libsvmtrain(label, data, svm_params);             %#ok<AGROW>
            if (cg(t+1,i,j) > best_acc) || (cg(t+1,i,j) == best_acc && best_c > base_num^X(i,j))
                [best_acc, best_t, best_c, best_g] = deal(cg(t+1,i,j), t, base_num^X(i,j), base_num^Y(i,j));
            end
        end
    end
end