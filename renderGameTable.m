function renderGameTable(window, sectionCenters, cardWidth, cardHeight, cardXPositions, cardBorderWidth)


cardSize = [0, 0, cardWidth, cardHeight];

% for each section
for sectionId = 1 : size(sectionCenters, 2)
    sectionCenterX = sectionCenters(1, sectionId);
    sectionCenterY = sectionCenters(2, sectionId);
    
    % for each card
    for cardXPosition = cardXPositions
        cardRect = CenterRectOnPointd(cardSize, cardXPosition + sectionCenterX, sectionCenterY);
        Screen('FrameRect', window, [0 0 0], cardRect, cardBorderWidth)
    end
    
end