%% shuffle of list
% - function [output, ner_order] = shuffle(input)
% - Variable
% ------------------------------------------input
% input         input list
% ------------------------------------------input
% output        shuffled list
% new_order     the order of each element after shuffle

function [output, new_order] = shuffle(input)

number = size(input, 1);                                                    % the length of input list
new_order = randperm(number);                                               % shuffle of order
output = input(new_order,:);                                                % new list

end