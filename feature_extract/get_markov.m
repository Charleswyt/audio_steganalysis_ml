%% Extract Markov transfer probability matrix feature
% - feature = get_markov(matrix, directions, T, order)
% - Variables:
% ------------------------------------------input
% matrix            input data
% directions        calculation direction
%
%   'h'   - horizontal | intra-frame
%   'v'   - vertical   | inter-frame
%   'd'   - diagonal
%   'm'   - minor diagonal
%   'hv'  - horizontal and vertical
%   'dm'  - diagonal and minor diagonal
%   'all' - all direction
%
% T                 threshold value
% order             the orcer of Markov feature
% -----------------------------------------output
% feature           the extracted feature vector

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

%% all direction
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

%% horizontal and vertical direction
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

%% diagonal direction
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

%% horizontal direction
if strcmp(directions, 'h') == 1
    %% horizontal (2T+1)^2 features
    Ad = max(min(matrix,T),-T);                 % truncate to [-T,T]
    A1 = Ad(:,1:end-order);
    A2 = Ad(:,1+order:end);
    feature = getTPM(A1,A2,T);
end

%% vertical direction
if strcmp(directions,'v') == 1
    %% vertical (2T+1)^2 features
    Ad = max(min(matrix,T),-T);                 % truncate to [-T,T]
    A1 = Ad(1:end-order,:);
    A2 = Ad(1+order:end,:);
    feature = getTPM(A1,A2,T);
end

%% diagonal direction
if strcmp(directions, 'd') == 1
    %% diagonal (2T+1)^2 feature
    Ad = max(min(matrix,T),-T);                 % truncate to [-T,T]
    A1 = Ad(1:end-order,1:end-order);
    A2 = Ad(1+order:end,1+order:end);
    feature = getTPM(A1,A2,T);
end

%% minor diagonal direction
if strcmp(directions, 'm') == 1
    %% minor diagonal (2T+1)^2 features
    Ad = max(min(matrix,T),-T);                 % truncate to [-T,T]
    A1 = Ad(1+order:end,1:end-order);
    A2 = Ad(1:end-order,1+order:end);
    feature = getTPM(A1,A2,T);
end