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
    
    %Open a window
    global windo
    [windo, ~] = PsychImaging('OpenWindow', screenNumber, white);
    
    % Get the size of the on screen window
    [screenXpixels, screenYpixels] = Screen('WindowSize', windo);

    % Set up alpha-blending for smooth (anti-aliased) lines
    Screen('BlendFunction', windo, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
    
    %Call the makecards function to set up the correct number/config of
    %cards
    dstRects = makecards(players);
    
    %draw the cards to the dstRects
    penWidthPixels = 6;
    Screen('FrameRect', windo, [0 0 0], dstRects, penWidthPixels)
    
    %Player labels--messy.
    Screen('TextSize', windo, 30);
    DrawFormattedText(windo, 'Red Player', screenXpixels * 0.11,...
        screenYpixels * 0.37, [1 0 0]);
    Screen('TextSize', windo, 30);
    DrawFormattedText(windo, 'Green Player', screenXpixels * 0.745,...
        screenYpixels * 0.37, [0 1 0]);
    
    if players > 3
        Screen('TextSize', windo, 30);
        DrawFormattedText(windo, 'Blue Player', screenXpixels * 0.11,...
            screenYpixels * 0.97, [0 0 1]);
    end
    
    if players == 4 || players == 6
        Screen('TextSize', windo, 30);
        DrawFormattedText(windo, 'Pink Player', screenXpixels * 0.77,...
            screenYpixels * 0.97, [1 0 1]);
    end
    
    if players == 5
        Screen('TextSize', windo, 30);
        DrawFormattedText(windo, 'Teal Player', screenXpixels * 0.42,...
            screenYpixels * 0.97, [0 1 1]);
    end
    
    if players ~= 4
        Screen('TextSize', windo, 30);
        DrawFormattedText(windo, 'Grey Player', screenXpixels * 0.42,...
            screenYpixels * 0.37, [0 0 0]);
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %This calls the generate images, which will eventually draw the random
    %shapes to the cards. For now, it partitions each card into halves that
    %can be used as dstRect for drawing an image to.
    generateimages(players)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Flip to the screen
    Screen('Flip', windo);
    
    %TO DO: insert some way to record keypresses
    
    % Wait for a keyboard button press to exit
    KbStrokeWait;
    sca
    
catch
    sca
end

end

