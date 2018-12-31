function [dstRect, subdstRect] = Trial(players)
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
    
    %define white and black
    white = WhiteIndex(screenNumber);
    
    %Eventually initialize this when we know how many trials/the trial
    %structure, will collect data from subject responses
    ResponseVector = [];
    
    %Open a window
    [window, ~] = Screen('OpenWindow', screenNumber);
    [windowWidth, windowHeight] = Screen('WindowSize', window);
    
    % Get the size of the on screen window
    %[screenXpixels, screenYpixels] = Screen('WindowSize', windo);
    
    % Set up alpha-blending for smooth (anti-aliased) lines
    Screen('BlendFunction', window, 'GL_SRC_ALPHA', ...
        'GL_ONE_MINUS_SRC_ALPHA');
    
    %Call the makecards function to set up the correct number/config of
    %cards
    
    %Below assignments are temporary for debugging
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
    
    [sectionCenters, sectionWidth, sectionHeight] = getSectionPositions(players, maxPlayersPerRow, windowWidth, windowHeight);
    [cardWidth, cardHeight, cardXPositions, labelYPosition, labelWidth, labelHeight] = getCardParameters(numCardsPerPlayer, cardAspectRatio, cardGapRelative, ...
        sectionMarginRelative, sectionWidth, sectionHeight);
    [objectWidth, objectHeight, objectYPositions] = getObjectParameters(cardWidth, cardHeight, cardBorderWidth, ...
        objectNum, objectAspectRatio);
    
    renderGameTable(window, sectionCenters, cardWidth, cardHeight, cardXPositions, cardBorderWidth, ...
        objectWidth, objectHeight, objectYPositions, cardConfig, imgDir, labelYPosition, labelWidth, labelHeight);
     
    %make labels
    %makelabels(players)
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %This calls the generate images, which will eventually draw the
    %random shapes to the cards. For now, it partitions each card
    %into halves that can be used as dstRect for drawing an image to.
    %generateimages(players)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
    %Get the click
    cardChoice = -1;
    while cardChoice <= 0
        cardChoice = recordclick(window, sectionCenters(:, 1), cardXPositions, cardHeight, cardWidth);
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

