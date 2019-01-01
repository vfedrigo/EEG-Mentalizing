function Trial(userDataPath, gameDataFilename, imgDir, gameConfig)
%% TODO: pass in this as parameter
userDataPath = 'data/';
gameDataFilename = 'gameData.mat';
imgDir = 'imgs/';
gameConfig.players = 8;
gameConfig.gameNum = 5;
gameConfig.maxPlayersPerRow = 3;
gameConfig.numCardsPerPlayer = 2;
gameConfig.sectionMarginRelative = 0.1;
gameConfig.cardGapRelative = 0.03;
gameConfig.cardAspectRatio = 1.5;
gameConfig.cardBorderWidth = 6;
gameConfig.objectNum = 3;
gameConfig.objectAspectRatio = 1.0;
gameConfig.cardConfigs = zeros(gameConfig.players, gameConfig.numCardsPerPlayer, gameConfig.objectNum, gameConfig.gameNum);
for i = 1 : gameConfig.gameNum
   gameConfig.cardConfigs(:, :, :, i) = randi(4, gameConfig.players, gameConfig.numCardsPerPlayer, gameConfig.objectNum);
end

%% Toolbox setup
%clear workspace and screen
sca;
close all;

%skip the sync error given on VF laptop
Screen('Preference','SkipSyncTests', 1);

%default settings
PsychDefaultSetup(2);

%get the screens
screens = Screen('Screens');
screenNumber = max(screens); %go to external if needed


try
    %% Initial window set up
    %Eventually initialize this when we know how many trials/the trial
    %structure, will collect data from subject responses
    ResponseVector = [];
    
    %Open a window
    [window, ~] = Screen('OpenWindow', screenNumber);
    [windowWidth, windowHeight] = Screen('WindowSize', window);
    
    % Set up alpha-blending for smooth (anti-aliased) lines
    Screen('BlendFunction', window, 'GL_SRC_ALPHA', ...
        'GL_ONE_MINUS_SRC_ALPHA');
    
    %% Log in
    loggedIn = false;
    while ~loggedIn
        [userId, userExist] = renderLoginPage(window, windowWidth, windowHeight, userDataPath, gameDataFilename);
        if userExist
            loggedIn = renderContinueExperimentConfirmation(window);
            if loggedIn
               %% Load existing data
               load( sprintf('%s/%s/%s', userDataPath, userId, gameDataFilename)); 
            end
        else
            loggedIn = true;
            %% Initialize New User Data
            mkdir(sprintf('%s/%s', userDataPath, userId));
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
            break;
        end
    end
    
    %% TODO: Ending page after all games finish
   
    sca
    
catch e
    sca
end

end

