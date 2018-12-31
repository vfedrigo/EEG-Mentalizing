function renderGameTable(window, sectionCenters, cardWidth, cardHeight, cardXPositions, cardBorderWidth, ...
    objectWidth, objectHeight, objectYPositions, cardConfig, imgDir, labelYPosition, labelWidth, labelHeight)

DrawFormattedText(window, 'Please click within the RED RECTANGLE BOUNDARIES and select one of your cards', 'center', ...
    round(min(sectionCenters(2,:)) / 2 - cardHeight / 4), [255, 0, 0]);

cardSize = [0, 0, cardWidth, cardHeight];
objectSize = [0, 0, objectWidth, objectHeight];

% for each section
for sectionId = 1 : size(sectionCenters, 2)
    sectionCenterX = sectionCenters(1, sectionId);
    sectionCenterY = sectionCenters(2, sectionId);
    if sectionId == 1
        labelText = 'Your Cards';
        textColor = 0;
    else
        labelText = sprintf('Player %d', sectionId);
        textColor = randi(255,1,3);
    end
    DrawFormattedText(window, labelText, 'center', 'center', ...
            textColor, [], [], [], [], [], ...
            CenterRectOnPointd([0, 0, labelWidth, labelHeight], sectionCenterX, sectionCenterY + labelYPosition)); 
        
    % for each card
    for cardId = 1 : length(cardXPositions);
        cardXPosition = cardXPositions(cardId);
        cardRect = CenterRectOnPointd(cardSize, cardXPosition + sectionCenterX, sectionCenterY);
        if sectionId == 1
           cardBorderColor = [255, 0, 0];
        else
           cardBorderColor = 0;
        end
        Screen('FrameRect', window, cardBorderColor, cardRect, cardBorderWidth)
        
        % for each object
        for objectId = 1 : length(objectYPositions); 
           objectYPosition = objectYPositions(objectId);
           objectConfig = cardConfig(sectionId, cardId, objectId);
           objectRect = CenterRectOnPointd(objectSize, cardXPosition + sectionCenterX, ...
               sectionCenterY + objectYPosition);
           objectImg = imread(sprintf('%s/%d.png', imgDir, objectConfig));
           texture = Screen('MakeTexture', window, objectImg);
           Screen('DrawTexture', window, texture, [], objectRect);
        end
    end
    
end

% Flip to the screen
Screen('Flip', window);