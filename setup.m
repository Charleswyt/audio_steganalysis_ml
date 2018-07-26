%% experiments init
%#ok<*SEPEX>
clc;
clear all;

current_files_path = pwd;

%% add path
addpath(genpath(fullfile(current_files_path, 'code')));
addpath(genpath(fullfile(current_files_path, 'models')));
addpath(genpath(fullfile(current_files_path, 'QMDCT_extraction')));

%% path init
current_files_path = pwd;

% QMDCT coefficients matrix files directory
cover_dir = fullfile(current_files_path, 'data\txt\cover');
stego_dir = fullfile(current_files_path, 'data\txt\stego');

% QMDCT coefficients matrices mat file directory
data_cover_mat_dir = fullfile(current_files_path, 'data\data_mat\cover');
data_stego_mat_dir = fullfile(current_files_path, 'data\data_mat\stego');

% feature files directory
feature_cover_mat_dir = fullfile(current_files_path, 'data\feature_mat\cover');
feature_stego_mat_dir = fullfile(current_files_path, 'data\feature_mat\stego');
feature_blind_dir = fullfile(current_files_path, 'data\feature_mat\blind'); % for model training
feature_for_test_dir = fullfile(current_files_path, 'for_test');            % for test

% model files path
model_files_path = fullfile(current_files_path, 'models');

%% creat folder
if ~exist(cover_dir, 'file') mkdir(cover_dir); end
if ~exist(stego_dir, 'file') mkdir(stego_dir); end

if ~exist(data_cover_mat_dir, 'file') mkdir(data_cover_mat_dir); end
if ~exist(data_stego_mat_dir, 'file') mkdir(data_stego_mat_dir); end

if ~exist(feature_cover_mat_dir, 'file') mkdir(feature_cover_mat_dir); end
if ~exist(feature_stego_mat_dir, 'file') mkdir(feature_stego_mat_dir); end
if ~exist(feature_blind_dir, 'file') mkdir(feature_blind_dir); end
if ~exist(feature_for_test_dir, 'file') mkdir(feature_for_test_dir); end

if ~exist(model_files_path, 'file') mkdir(model_files_path); end