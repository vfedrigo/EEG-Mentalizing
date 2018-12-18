function [cardChoice] = recordclick(whichPlayer, sectionCenters, ...
    cardXPositions, cardHeight, cardWidth)

[~, clickX, clickY] = GetClicks;

%Define which cards we're looking at (in case we later randomize the
%position of the participant) 
playerCenter = sectionCenters(:, whichPlayer) %center of the section

%Define the player's card edges
playerCardXpos = [playerCenter(1) + cardXPositions(1), ...
    playerCenter(1) + cardXPositions(2)] %left card center, right card center

playerLeftCard = [playerCardXpos(1) - 0.5*cardWidth,...
    playerCardXpos(1) + 0.5*cardWidth]

playerRightCard = [playerCardXpos(2) - 0.5*cardWidth,...
    playerCardXpos(2) + 0.5*cardWidth]

playerCardYpos = [sectionCenters(2, whichPlayer) + 0.5*cardHeight, ...
    sectionCenters(2, whichPlayer) - 0.5*cardHeight] %top half, bottom half

%Defining the clicks as being either in or out of range
XconditionLeft = ((clickX < (playerLeftCard(2))) && ...
    (clickX > (playerLeftCard(1))))
YconditionLeft = ((clickY < (playerCardYpos(1))) && ...
    (clickX > (playerCardYpos(2))))

XconditionRight = ((clickX < (playerRightCard(2))) && ...
    (clickX >(playerRightCard(1))))
YconditionRight = ((clickY < (playerCardYpos(1))) && ...
    (clickX > (playerCardYpos(2))))

if  XconditionLeft + YconditionLeft == 2
    cardChoice = 1; %1 is left
elseif XconditionRight + YconditionRight == 2
    cardChoice = 0;
    
else disp('You did not click on your own cards. Please try again')
    cardChoice = -99;
    %make this in a popup
end

%Show some sort of dialogue to confirm the click 
%This is under construction, but currently prints
%the card selected (left or right) correctly

end
