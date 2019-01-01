function [userId, shouldExit, currentGameId, userChoice] = Trial(userDataPath, gameDataFilename, imgDir, ...
    window, windowWidth, windowHeight, gameConfig, inputUserId)
%% Log in
shouldExit = false;
loggedIn = false;
while ~loggedIn
    if isempty(inputUserId)
        [userId, userExist] = renderLoginPage(window, windowWidth, windowHeight, userDataPath, gameDataFilename);
    else
       userId = inputUserId;
       userExist = exist(sprintf('%s/%s/%s', userDataPath, userId, gameDataFilename), 'file');
    end
    if userExist
        loggedIn = ~isempty(inputUserId) || renderContinueExperimentConfirmation(window);
        if loggedIn
           %% Load existing data
           load( sprintf('%s/%s/%s', userDataPath, userId, gameDataFilename)); 
        end
    else
        loggedIn = true;
        %% Initialize New User Data
        if ~exist(sprintf('%s/%s', userDataPath, userId), 'dir')
            mkdir(sprintf('%s/%s', userDataPath, userId));
        end
        currentGameId = 1;
        userChoice = zeros(1, gameConfig.gameNum);
        save(sprintf('%s/%s/%s', userDataPath, userId, gameDataFilename), 'gameConfig', 'currentGameId', 'userChoice');
    end
end

%% Load Game Config
players = gameConfig.players;
gameNum = gameConfig.gameNum;
maxPlayersPerRow = gameConfig.maxPlayersPerRow;
numCardsPerPlayer = gameConfig.numCardsPerPlayer;
sectionMarginRelative = gameConfig.sectionMarginRelative;
cardGapRelative = gameConfig.cardGapRelative;
cardAspectRatio = gameConfig.cardAspectRatio;
cardBorderWidth = gameConfig.cardBorderWidth;
objectNum = gameConfig.objectNum;
objectAspectRatio = gameConfig.objectAspectRatio;

for gameId = currentGameId : gameNum
    cardConfig = gameConfig.cardConfigs(:, :, :, gameId);
    %% Render game on screen
    [sectionCenters, sectionWidth, sectionHeight] = getSectionPositions(players, maxPlayersPerRow, windowWidth, windowHeight);
    [cardWidth, cardHeight, cardXPositions, labelYPosition, labelWidth, labelHeight] = getCardParameters(numCardsPerPlayer, cardAspectRatio, cardGapRelative, ...
        sectionMarginRelative, sectionWidth, sectionHeight);
    [objectWidth, objectHeight, objectYPositions] = getObjectParameters(cardWidth, cardHeight, cardBorderWidth, ...
        objectNum, objectAspectRatio);

    cardChoice = -1;
    renderGameTable(window, sectionCenters, cardWidth, cardHeight, cardXPositions, cardBorderWidth, ...
        objectWidth, objectHeight, objectYPositions, cardConfig, imgDir, labelYPosition, labelWidth, labelHeight, ...
        cardChoice);

    %% Get the click
    while cardChoice <= 0
        cardChoice = recordclick(window, sectionCenters(:, 1), cardXPositions, cardHeight, cardWidth);
    end

    %% Save game data
    userChoice(gameId) = cardChoice;
    currentGameId = gameId + 1;
    save(sprintf('%s/%s/%s', userDataPath, userId, gameDataFilename), 'gameConfig', 'currentGameId', 'userChoice');

    %% Press enter for next game
    if ~renderGameTable(window, sectionCenters, cardWidth, cardHeight, cardXPositions, cardBorderWidth, ...
            objectWidth, objectHeight, objectYPositions, cardConfig, imgDir, labelYPosition, labelWidth, labelHeight, ...
            cardChoice);
        shouldExit = true;
        break;
    end
end    

end

