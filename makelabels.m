function [labelStruct] ...
    = makelabels(centerPositions, sectionHeight, players)

%currently accomodates up to 6 players, but can be expanded by addding new
%color/player names and new color RGB codes. the positions should define
%themselves without any extra work.

labels = {'Your Cards', 'Grey Player', 'Green Player'; 'Blue Player', ...
    'Pink Player', 'Teal Player'};
colors = {[1 0 0], [0 0 0], [0 1 0], [0 0 1], [1 0 1], [0 1 1]};


%Taken from the Contents script as a way to loop through struct
indexPlayers = compose('p%d', 1:players); %struct is labelStruct.p(#)

labelStruct = struct(); %can be initialized in some way? is there a zeros
%for structures?

%unpacking the centerpositions
xPositions = zeros(1, players);
yPositions = zeros(1, players);
for pos = 1:players
    xPositions(pos) = centerPositions(1, pos);
    yPositions(pos) = centerPositions(2, pos) + (0.4 * sectionHeight);
end

%filling the label struct
for index = 1:players
    tempIndex = char(indexPlayers(index));
    labelStruct.(tempIndex) = {labels{index}, colors{index}, ... 
        xPositions, yPositions};
end

%%This structre is passed to the drawContents function.

end

