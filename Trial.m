function [dstRect, subdstRect] = Trial(players)
%% TODO: pass in this as parameter
userDataPath = 'data/';

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
        [userId, userExist] = renderLoginPage(window, windowWidth, windowHeight, userDataPath);
        if userExist
            loggedIn = renderContinueExperimentConfirmation(window);
            if loggedIn
               %% Load Existing User data 
            end
        else
            loggedIn = true;
            %% Initialize New User Data
            mkdir(sprintf('%s/%s', userDataPath, userId));
            
        end
    end
    
    for gameId = 1 : 5
        %% Load Game Config
        % Below assignments are temporary for debugging
        players = 8   ;
        maxPlayersPerRow = 3;
        numCardsPerPlayer = 2;
        sectionMarginRelative = 0.1;
        cardGapRelative = 0.03;
        cardAspectRatio = 1.5;
        cardBorderWidth = 6;
        objectNum = 3;
        objectAspectRatio = 1.0;
        cardConfig = randi(4, players, numCardsPerPlayer, objectNum);
        imgDir = 'imgs/';
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
        
        if ~renderGameTable(window, sectionCenters, cardWidth, cardHeight, cardXPositions, cardBorderWidth, ...
                objectWidth, objectHeight, objectYPositions, cardConfig, imgDir, labelYPosition, labelWidth, labelHeight, ...
                cardChoice);
            break;
        end
    end
    
    % %This way at the end there'll be a vector with all the choices, can
    % %compare to the different playing strategies
    % ResponseVector = cat(2, ResponseVector, cardChoice);
    % disp(ResponseVector)
   
    sca
    
catch e
    sca
end

end

