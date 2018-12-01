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
black = BlackIndex(screenNumber);

%Open a window
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, white);

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the center coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

% Set up alpha-blending for smooth (anti-aliased) lines
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% Here we load in an image from file. This one is a image of rabbits that
% is included with PTB
theImageLocation = ['Card Shape.png'];
theImage = imread(theImageLocation);
theImage = imresize(theImage,[150 NaN]);

% Make the image into a texture
imageTexture = Screen('MakeTexture', window, theImage);

% Get the size of the image
[s1, s2, s3] = size(theImage);

%%TEST PART HERE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dstRects = makecardsDUPLICATE(players)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Draw the image to the screen, unless otherwise specified PTB will draw
% the texture full size in the center of the screen.
Screen('DrawTextures', window, imageTexture, [], dstRects);

%Player labels
Screen('TextSize', window, 30);
DrawFormattedText(window, 'Red Player', screenXpixels * 0.11,...
    screenYpixels * 0.37, [1 0 0]);
Screen('TextSize', window, 30);
DrawFormattedText(window, 'Blue Player', screenXpixels * 0.11,...
    screenYpixels * 0.97, [0 1 0]);
Screen('TextSize', window, 30);
DrawFormattedText(window, 'Green Player', screenXpixels * 0.78,...
    screenYpixels * 0.37, [0 0 1]);
Screen('TextSize', window, 30);
DrawFormattedText(window, 'Pink Player', screenXpixels * 0.78,...
    screenYpixels * 0.97, [1 0 1]);
Screen('TextSize', window, 30);
DrawFormattedText(window, 'Teal Player', screenXpixels * 0.42,...
    screenYpixels * 0.97, [0 1 1]);
Screen('TextSize', window, 30);
DrawFormattedText(window, 'Grey Player', screenXpixels * 0.42,...
    screenYpixels * 0.37, [0 0 0]);

%Add in card shapes (CHANGE THIS TO BE FLEXIBLE)
%eventually, make function that will randomize cards & still be solvable


% Flip to the screen
Screen('Flip', window);

% Wait for a keyboard button press to exit
KbStrokeWait;
sca

catch
    sca
    display('you got an error')
end

