function [] ...
    = generateLabels(sectionCenters, sectionHeight, players, cardHeight, ...
    cardBorderWidth, sectionWidth, cardWidth)

%currently accomodates up to 7 players, but can be expanded by addding new
%color/player names and new color RGB codes

%This isn't ideal and might be a temporary fix,  but it wasn't accepting
%window as an input (said 'no open windows')
global window 

%Lists currently must be expanded manually-- potential room for improvement
labels = {'Your Cards', 'Grey Player', 'Green Player', 'Blue Player', ...
    'Pink Player', 'Teal Player', 'Yellow Player'};
colors = {[1 0 0], [0 0 0], [0 1 0], [0 0 1], [1 0 1], [0 1 1], [1 1 0]};


%Find which label is the longest, serve as basis for text size calculations
temp = [];
for i = 1:length(labels)
    tempSize = size(labels{i});
    temp = cat(2, temp, tempSize(2));
end
longestString = max(temp);
posLongest = temp == longestString;

%Draw large text and find its size (to serve as basis for scaling text size
%down to fit in necessary space)
Screen('TextSize', window, 80);
[~, ~, textBounds] = DrawFormattedText(window, labels{posLongest}, ...
    100, 100, [1 1 1]); %draws in white, so shouldn't show up


%Size of the rectangle required to fit the longest string in the big text
bigTextRect = [ceil((textBounds(3) - textBounds(1))),...
    ceil((textBounds(4) - textBounds(2)))];

%This is the size of the box available in the current configuration, so the
%space the label should fit into
finalboxSize = [sectionWidth, (sectionHeight - cardHeight - cardBorderWidth)];

%Find the ratios between the two boxes and scale depending on which
%dimension is the limiting factor to find an ultimate scaling ratio 
boxXratio = finalboxSize(1)/bigTextRect(1);
boxYratio = finalboxSize(2)/bigTextRect(2);

finalRatio = max(boxXratio, boxYratio);

finalTextSize = floor(30 * finalRatio);


%Taken from the Contents script as a way to loop through struct
indexPlayers = compose('p%d', 1:players); %struct is labelStruct.p(#)

labelStruct = struct(); %can be initialized in some way? is there a zeros
%for structures?

%unpacking the centerPositions from getCardPositions
xPositions = zeros(1, players);
yPositions = zeros(1, players);
for pos = 1:players
    xPositions(pos) = sectionCenters(1, pos) - cardWidth;
    %Thinking of ways to remove this scalar... tested for 
    yPositions(pos) = sectionCenters(2, pos) + (0.7 * cardHeight);
end


%filling the label struct. each row is the information for one player
%format: p1: 'color label', RGB code, xPosition, yPosition
for index = 1:players
    tempIndex = char(indexPlayers(index));
    labelStruct.(tempIndex) = {labels{index}, colors{index}, ... 
        xPositions(index), yPositions(index)};
end

%Drawing in the labels to the screen using the label struct
  Screen('TextSize', window, finalTextSize);
  for playerCount = 1:players
      tempIndex = char(indexPlayers(playerCount));
    DrawFormattedText(window, labelStruct.(tempIndex){1}, ...
        labelStruct.(tempIndex){3}, ...
        labelStruct.(tempIndex){4}, labelStruct.(tempIndex){2});
  end

end