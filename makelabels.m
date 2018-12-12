function [labels, colors, positions] ...
    = makelabels(players)


%%Order of all the following is the same, so the nth term in the labels
%%array corresponds to colors{n}, etc. Sizes are 30 for text display

labels = {'Your Cards', 'Grey Player', 'Green Player'; 'Blue Player', ...
    'Pink Player', 'Teal Player'};

colors = {[1 0 0], [0 0 0], [0 1 0], [0 0 1], [1 0 1], [0 1 1]};

positions = {[0.11, 0.37], [0.78, 0.37], [0.11, 0.97], ...
    [0.77, 0.97], [0.42, 0.97], [0.42, 0.37]};

loopVector = [1;3;4;6;2;5];

%%make a solid correspondence between label position and card position
%%can label be put into cards so it's not a separate script
%%change so index is 6 (1-6)
%%find way to correlate text and card positions
end
