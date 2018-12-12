function dstRects = makecards(players,perObjectOnCards,window)
cardnumber = players*perObjectOnCards;

%%extend screen to projector, needs to move on directory later as well.
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
 
if players < 3 || players >6
    print('invalid number of players, please enter between 3-6')
    exit
end

%Defining the dstRects for the cards. 
baseRect = [0 0 180 250];

%Each column is a different rectangle/card
dstRects = zeros(4, cardnumber);


%%FINALIZE AND OR CHANGE THESE
xCoordinates = [0.10,0.24,0.43,0.57,0.76,0.90];
yCoordinates = [0.2,0.8];

%%These loops will need to change so that it goes through the TBD loopindex
%%variable, where it goes by order in which things are filled out. 
%%Need to fix the proportions too, but maybe being phased out? 

for yIndex = 1:length(yCoordinates)
    for xIndex = 1:length(xCoordinates)
        if yIndex == 1
            dstRects(:, xIndex) = CenterRectOnPointd(baseRect,...
                screenXpixels * xCoordinates(xIndex), ...
                screenYpixels * yCoordinates(yIndex));
        end
        if yIndex == 2
            dstRects(:, (xIndex + length(xCoordinates))) =  ... 
                CenterRectOnPointd(baseRect,...
                screenXpixels * xCoordinates(xIndex), ...
                screenYpixels * yCoordinates(yIndex));
        end
    end
end

% %Setting up the configurations for the cards. 
% if players == 3
%     dstRects = cat(2, dstRects(:, 1:2), dstRects(:, 5:6), dstRects(:, 9:10));
% elseif players == 4
%     dstRects = cat(2, dstRects(:, 1:2), dstRects(:, 5:8), dstRects(:, 11:12));
% elseif players == 5
%     dstRects = dstRects(:, 1:10);
% end
