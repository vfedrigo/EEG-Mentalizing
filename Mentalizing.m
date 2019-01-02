function Mentalizing

%% Constants
userDataPath = 'data/';
imgDir = 'imgs/';
cardConfigDir = 'cardConfigs';
reGenerate = false;
cardPoolSize = 20;

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
    
    %Open a window
    [window, ~] = Screen('OpenWindow', screenNumber);
    [windowWidth, windowHeight] = Screen('WindowSize', window);
    
    % Set up alpha-blending for smooth (anti-aliased) lines
    Screen('BlendFunction', window, 'GL_SRC_ALPHA', ...
        'GL_ONE_MINUS_SRC_ALPHA');
    
    %% Trial 1
    gameDataFilename = 'trial_1.mat';
    gameConfig.players = 3;
    gameConfig.gameConfigNum = 2;
    gameConfig.maxPlayersPerRow = 3;
    gameConfig.numCardsPerPlayer = 2;
    gameConfig.sectionMarginRelative = 0.1;
    gameConfig.cardGapRelative = 0.03;
    gameConfig.cardAspectRatio = 1.5;
    gameConfig.cardBorderWidth = 6;
    gameConfig.objectNum = 3;
    gameConfig.objectAspectRatio = 1.0;
    gameConfig.maxObjectCount = 7;
    %gameConfig.gameNum = gameConfig.gameConfigNum * gameConfig.players;
    %gameConfig.cardConfigs = zeros(gameConfig.players, gameConfig.numCardsPerPlayer, gameConfig.objectNum, gameConfig.gameNum);
    %for i = 1 : gameConfig.gameNum
    %   gameConfig.cardConfigs(:, :, :, i) = randi(4, gameConfig.players, gameConfig.numCardsPerPlayer, gameConfig.objectNum);
    %end
    gameConfig = getCardConfigs(gameConfig, cardConfigDir, cardPoolSize, reGenerate);
    [userId, shouldExit] = Trial(userDataPath, gameDataFilename, imgDir, window, windowWidth, ...
        windowHeight, gameConfig, []);
    if shouldExit
        sca;
        return;
    end
    
    %% Trial 2
    gameDataFilename = 'trial_2.mat';
    gameConfig.players = 5;
    gameConfig.gameConfigNum = 2;
    %gameConfig.cardConfigs = zeros(gameConfig.players, gameConfig.numCardsPerPlayer, gameConfig.objectNum, gameConfig.gameNum);
    %for i = 1 : gameConfig.gameNum
    %   gameConfig.cardConfigs(:, :, :, i) = randi(4, gameConfig.players, gameConfig.numCardsPerPlayer, gameConfig.objectNum);
    %end
    gameConfig = getCardConfigs(gameConfig, cardConfigDir, cardPoolSize, reGenerate);
    [~, shouldExit] = Trial(userDataPath, gameDataFilename, imgDir, window, windowWidth, ...
        windowHeight, gameConfig, userId);
    if shouldExit
        sca;
        return;
    end
    
    %% TODO: Ending page after all games finish
    
    sca
    
catch e
    sca
end

end