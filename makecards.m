function dstRects = makecards(players) %want to have it spit out the dstrect matrix
cardnumber = players*2;

global windo
[screenXpixels, screenYpixels] = Screen('WindowSize', windo);
 

if players < 3 || players >6
    print('invalid number of players, please enter between 3-6')
    exit
end

%Defining the dstRects for the cards.
baseRect = [0 0 180 250];

%Each column is a different rectangle/card
dstRects = zeros(4, cardnumber);

xCoordinates = [0.10, 0.24,  0.43, 0.57,  0.76, 0.90];
yCoordinates = [0.2, 0.8];

for yIndex = 1:2
    for xIndex = 1:6
        if yIndex == 1
            dstRects(:, xIndex) = CenterRectOnPointd(baseRect,...
                screenXpixels * xCoordinates(xIndex), ...
                screenYpixels * yCoordinates(yIndex));
        end
        if yIndex == 2
            dstRects(:, (xIndex + 6)) = CenterRectOnPointd(baseRect,...
                screenXpixels * xCoordinates(xIndex), ...
                screenYpixels * yCoordinates(yIndex));
        end
    end
end

%Setting up the configurations for the cards. 
if players == 3
    dstRects = cat(2, dstRects(:, 1:2), dstRects(:, 5:6), dstRects(:, 9:10));
elseif players == 4
    dstRects = cat(2, dstRects(:, 1:2), dstRects(:, 5:8), dstRects(:, 11:12));
elseif players == 5
    dstRects = dstRects(:, 1:10);
end

end