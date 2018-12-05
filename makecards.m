function dstRects = makecards(players) %want to have it spit out the destrect matrix
cardnumber = players*2;

%This is temporary, will be defined via the Screen function
screenXpixels = 1366; 
screenYpixels = 768;  

if players < 3 || players >6
    print('invalid number of players, please enter between 3-6')
    exit
end

%Defining the dstRects for the cards. This may be changed to be more
%flexible/neater/better once other functions are sorted out.
baseRect = [0 0 180 250];

dstRects = nan(4, cardnumber);
dstRects(:, 1) = CenterRectOnPointd(baseRect,... %top left
    screenXpixels * 0.10, screenYpixels * 0.2);
dstRects(:, 2) = CenterRectOnPointd(baseRect,...
    screenXpixels * 0.24, screenYpixels * 0.2);
dstRects(:, 3) = CenterRectOnPointd(baseRect,... %bottom left
    screenXpixels * 0.10, screenYpixels * 0.8);
dstRects(:, 4) = CenterRectOnPointd(baseRect,...
    screenXpixels * 0.24, screenYpixels * 0.8);
dstRects(:, 5) = CenterRectOnPointd(baseRect,... %top right
    screenXpixels * 0.76, screenYpixels * 0.2);
dstRects(:, 6) = CenterRectOnPointd(baseRect,...
    screenXpixels * 0.90, screenYpixels * 0.2);
dstRects(:, 7) = CenterRectOnPointd(baseRect,...%bottom right
    screenXpixels * 0.76, screenYpixels * 0.8);
dstRects(:, 8) = CenterRectOnPointd(baseRect,...
    screenXpixels * 0.90, screenYpixels * 0.8);
dstRects(:, 9) = CenterRectOnPointd(baseRect,... %top middle
    screenXpixels * 0.43, screenYpixels * 0.2); 
dstRects(:, 10) = CenterRectOnPointd(baseRect,... 
    screenXpixels * 0.57, screenYpixels * 0.2); 
dstRects(:, 11) = CenterRectOnPointd(baseRect,... %top middle
    screenXpixels * 0.43, screenYpixels * 0.8); 
dstRects(:, 12) = CenterRectOnPointd(baseRect,... %bot middle
    screenXpixels * 0.57, screenYpixels * 0.8); 

%Setting up the configurations for the cards. Same comment as above
if players ==3
    dstRects = cat(2, dstRects(:, 1:2), dstRects(:, 5:6), dstRects(:, 11:12));
elseif players == 4
    dstRects = dstRects(:, 1:8);
elseif players == 5
    dstRects = cat(2, dstRects(:, 1:2), dstRects(:, 9:12), dstRects(:, 3:6));
end
end