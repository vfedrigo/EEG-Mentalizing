function [cardChoice] = recordclick(players)
%eventually figure out what the input should be--trial number?

global windo
[~, clickX, clickY] = GetClicks;
[screenXpixels, screenYpixels] = Screen('WindowSize', windo);


XconditionLeft = ((clickX < (screenXpixels * 0.10 + 90)) && ...
    (clickX > (screenXpixels * 0.10 - 90)));
YconditionLeft = ((clickY < (screenYpixels * 0.2 + 125)) && ...
    (clickX > (screenXpixels * 0.2 - 125)));

XconditionRight = ((clickX < (screenXpixels * 0.24 + 90)) && ...
    (clickX >(screenXpixels * 0.24 - 90)));
YconditionRight = ((clickY < (screenYpixels * 0.2 + 125)) && ...
    (clickX > (screenXpixels * 0.2 - 125)));

if  XconditionLeft + YconditionLeft == 2
    cardChoice = 'left';
elseif XconditionRight + YconditionRight == 2
    cardChoice = 'right';
    
else disp('Click out of range. Please make a valid selection')
    cardChoice = 'invalid';
    %make this in a popup
end

%Show some sort of dialogue to confirm the click 
%This is under construction

end
