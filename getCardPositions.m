function [centerPositions, minSectionWidth, sectionHeight] = getCardPositions(players, maxPlayerNumPerRow, window)

[width, height] = Screen('WindowSize', window);

rowNum = ceil(players / maxPlayerNumPerRow);
sectionHeight = height / rowNum;
minSectionWidth = width;

centerPositions = zeros(2, players);

for playerId = 1 : players
   
    rowId = ceil(playerId / maxPlayerNumPerRow);
    if rowId < rowNum
        sectionWidth = width / maxPlayerNumPerRow;
    else
        sectionWidth = width / (mod(players - 1, maxPlayerNumPerRow) + 1);
    end
    minSectionWidth = min(minSectionWidth, sectionWidth);
    ySectionCenterPosition = (rowId - 0.5) * sectionHeight;
    xSectionCenterPosition = (mod(playerId - 1, maxPlayerNumPerRow) + 0.5) * sectionWidth;
    centerPositions(:, playerId) = [xSectionCenterPosition, ySectionCenterPosition];
    
end