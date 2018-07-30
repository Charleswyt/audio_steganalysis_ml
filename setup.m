%% experiments init
%#ok<*SEPEX>
clc;

current_files_path = pwd;

%% add path
addpath(genpath(fullfile(current_files_path, 'application')));
addpath(genpath(fullfile(current_files_path, 'batch_script')));
addpath(genpath(fullfile(current_files_path, 'feature_extract')));
addpath(genpath(fullfile(current_files_path, 'plot')));
addpath(genpath(fullfile(current_files_path, 'train_test')));
addpath(genpath(fullfile(current_files_path, 'utils')));

clear current_files_path