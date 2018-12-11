function [cardChoice] = recordclick(players, cardsize)
%eventually figure out what the input should be--trial number?

global windo
[~, clickX, clickY] = GetClicks;
[screenXpixels, screenYpixels] = Screen('WindowSize', windo);

cardsizeX = cardsize(:,1)
cardsizeY = cardszie(:,2)


XconditionLeft = ((clickX < (screenXpixels * 0.10 + 0.5*cardsizeX)) && ...
    (clickX > (screenXpixels * 0.10 - 0.5*cardsizeX)));
YconditionLeft = ((clickY < (screenYpixels * 0.2 + 0.5*cardsizeY)) && ...
    (clickX > (screenXpixels * 0.2 - 0.5*cardsizeY)));

XconditionRight = ((clickX < (screenXpixels * 0.24 + 0.5*cardsizeX)) && ...
    (clickX >(screenXpixels * 0.24 - 0.5*cardsizeX)));
YconditionRight = ((clickY < (screenYpixels * 0.2 + 0.5*cardsizeY)) && ...
    (clickX > (screenXpixels * 0.2 - 0.5*cardsizeY)));

if  XconditionLeft + YconditionLeft == 2
    cardChoice = 'left';
elseif XconditionRight + YconditionRight == 2
    cardChoice = 'right';
    
else disp('Click out of range. Please make a valid selection')
    cardChoice = 'invalid';
    %make this in a popup
end

%Show some sort of dialogue to confirm the click 
%This is under construction, but currently prints
%the card selected (left or right) correctly

end
