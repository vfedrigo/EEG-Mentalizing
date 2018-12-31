function [objectWidth, objectHeight, objectYPositions] = getObjectParameters(cardWidth, cardHeight, cardBorderWidth, objectNum, objectAspectRatio)

maxObjectHeight = floor((cardHeight - 2 * cardBorderWidth) / objectNum);
maxObjectWidth = cardWidth - 2 * cardBorderWidth;

if maxObjectHeight > maxObjectWidth * objectAspectRatio
    objectHeight = floor(maxObjectWidth * objectAspectRatio);
    objectWidth = maxObjectWidth;
else
    objectHeight = maxObjectHeight;
    objectWidth = floor(maxObjectHeight / objectAspectRatio);
end

objectYPositions = ([1 : objectNum] - (objectNum + 1) / 2) * objectHeight;
