%% Extract Markov transfer probability matrix feature (提取Markov特征)
% - feature = get_markov(matrix, directions, T, order)
% - Variables:
% ------------------------------------------input
% matrix            input data (待处理的矩阵数据)
% directions        calculation direction (计算方向)
%
%   'h'   - horizontal | intra-frame     (水平方向 | 帧内)
%   'v'   - vertical   | inter-frame     (竖直方向 | 帧间)
%   'd'   - diagonal                     (主对角线方向)
%   'm'   - minor diagonal               (次对角线方向)
%   'hv'  - horizontal and vertical      (水平竖直方向 | 帧内帧间)
%   'dm'  - diagonal and minor diagonal  (对角线方向)
%   'all' - all direction                (所有方向)
%
% T                 threshold value (截断阈值)
% order             the orcer of Markov feature (阶数)
% -----------------------------------------output
% feature           the extracted feature vector (提取的特征向量)

function feature = get_markov(matrix, directions, T, order)

if ~exist('directions', 'var') || isempty(directions)
    order = 'hv';
end

if ~exist('T', 'var') || isempty(T)
    T = 15;
end

if ~exist('order', 'var') || isempty(order)
    order = 1;
end

%% all direction (所有方向)
if strcmp(directions, 'all') == 1
    feature = [];
    %% horizontal (2T+1)^2 features
    Ad = max(min(matrix,T),-T);                 % truncate to [-T,T]
    A1 = Ad(:,1:end-order);
    A2 = Ad(:,1+order:end);
    feature = [feature;getTPM(A1,A2,T)];
    
    %% vertical (2T+1)^2 features
    Ad = max(min(matrix,T),-T);                 % truncate to [-T,T]
    A1 = Ad(1:end-order,:);
    A2 = Ad(2:end,:);
    feature = [feature;getTPM(A1,A2,T)];

    %% diagonal (2T+1)^2 feature
    Ad = max(min(matrix,T),-T);                 % truncate to [-T,T]
    A1 = Ad(1:end-order,1:end-order);
    A2 = Ad(1+order:end,1+order:end);
    feature = [feature;getTPM(A1,A2,T)];
    
    %% minor diagonal (2T+1)^2 features
    Ad = max(min(matrix,T),-T);                 % truncate to [-T,T]
    A1 = Ad(1+order:end,1:end-order);
    A2 = Ad(1:end-order,1+order:end);
    feature = [feature;getTPM(A1,A2,T)];
end

%% horizontal and vertical direction (水平竖直方向)
if strcmp(directions, 'hv') == 1
    feature = [];
    %% horizontal (2T+1)^2 features
    Ad = max(min(matrix,T),-T);                 % truncate to [-T,T]
    A1 = Ad(:,1:end-order);
    A2 = Ad(:,1+order:end);
    feature = [feature;getTPM(A1,A2,T)];
    
    %% vertical (2T+1)^2 features
    Ad = max(min(matrix,T),-T);                 % truncate to [-T,T]
    A1 = Ad(1:end-order,:);
    A2 = Ad(1+order:end,:);
    feature = [feature;getTPM(A1,A2,T)];
end    

%% diagonal direction (对角线方向)
if strcmp(directions, 'dm') == 1
    feature = [];
    %% diagonal (2T+1)^2 features
    Ad = max(min(matrix,T),-T);                 % truncate to [-T,T]
    A1 = Ad(1:end-order,1:end-order);
    A2 = Ad(1+order:end,1+order:end);
    feature = [feature;getTPM(A1,A2,T)];
    
    %% minor diagonal (2T+1)^2 features
    Ad = max(min(matrix,T),-T);                 % truncate to [-T,T]
    A1 = Ad(1+order:end,1:end-order);
    A2 = Ad(1:end-order,1+order:end);
    feature = [feature;getTPM(A1,A2,T)];

end

%% horizontal direction (水平方向)
if strcmp(directions, 'h') == 1
    %% horizontal (2T+1)^2 features
    Ad = max(min(matrix,T),-T);                 % truncate to [-T,T]
    A1 = Ad(:,1:end-order);
    A2 = Ad(:,1+order:end);
    feature = getTPM(A1,A2,T);
end

%% vertical direction (竖直方向)
if strcmp(directions,'v') == 1
    %% vertical (2T+1)^2 features
    Ad = max(min(matrix,T),-T);                 % truncate to [-T,T]
    A1 = Ad(1:end-order,:);
    A2 = Ad(1+order:end,:);
    feature = getTPM(A1,A2,T);
end

%% diagonal direction (对角线方向)
if strcmp(directions, 'd') == 1
    %% diagonal (2T+1)^2 feature
    Ad = max(min(matrix,T),-T);                 % truncate to [-T,T]
    A1 = Ad(1:end-order,1:end-order);
    A2 = Ad(1+order:end,1+order:end);
    feature = getTPM(A1,A2,T);
end

%% minor diagonal direction (次对角线方向)
if strcmp(directions, 'm') == 1
    %% minor diagonal (2T+1)^2 features
    Ad = max(min(matrix,T),-T);                 % truncate to [-T,T]
    A1 = Ad(1+order:end,1:end-order);
    A2 = Ad(1:end-order,1+order:end);
    feature = getTPM(A1,A2,T);
end