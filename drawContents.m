function [] = drawContents(players, centerPositions, ...
    minSectionWidth, sectionHeight)

%%This function draws in the cards and affixes the labels. There is no
%%display in this code, and it will be called by the Trial function which
%%will then display everything at the end. The label function calls 
%%another function, makelabels, just to have a structure with the
%%color/positioning/etc information.

%%FUNCTION TO DO: 
%%it doesn't generate or place images
%%the proportions/sizes need to be checked
%%does there need to be a function that changes text sizes?
%%the playerStruct most likely will need to store more information


%determine card size
cardWidth = 0.45*minSectionWidth; %proportions can be played with
cardHeight = 0.7*sectionHeight;
cardSize = [0 0 cardWidth cardHeight];

%Data structure for all player information
%necessary variables initialized, filled in in loop
playerStruct = struct(); %initialize somehow later on?
indexPlayers = compose('p%d', 1:players); %for .index, playerstruct.p(#)


for playerId = 1:players
    
    %determine left and right card centers
    %cards along the center line in terms of y-coordinattes
    %Split into x,y bc frameRect requires separate X and Y coords
    leftCardCenterX = (centerPositions(1, playerId) - ...
        .25*minSectionWidth);
    leftCardCenterY = (centerPositions(2, playerId));
    leftCardCenter = cat(2, leftCardCenterX, leftCardCenterY);
    
    rightCardCenterX = (centerPositions(1, playerId) + ...
        .25*minSectionWidth);
    rightCardCenterY = (centerPositions(2, playerId));
    rightCardCenter = cat(2, rightCardCenterX, rightCardCenterY);
    
    cardAreaL = CenterRectOnPointd(cardSize, leftCardCenterX, ...
        leftCardCenterY);
    cardAreaR = CenterRectOnPointd(cardSize, rightCardCenterX, ...
        rightCardCenterY);
    
    %actually draws the cards
    %need to initialize window first? or is it windo? check this
    penWidthPixels = 6;
    Screen('FrameRect', window, [0 0 0], cardAreaR, penWidthPixels)
    Screen('FrameRect', window, [0 0 0], cardAreaL, penWidthPixels)
    
    %starts filling the struct with relevant info
    tempIndex = char(indexPlayers(playerID));
    playerStruct.(tempIndex) = {leftCardCenter, rightCardCenter};

end

%the label struct, separate from the player data bc less important
labelStruct = makelabels(centerPositions, minSectionWidth, ...
    sectionHeight, players);
loopVector = [1, 3, 4, 6, 2, 5]; %order we're drawing in, can be changed!

for labelIndex = 1:players
    
    whichPlayer = labelIndex(loopVector); %so it goes in right draw order
    Screen('TextSize', window, 30) %do we need to worry abt text size?
    
    %later, this can be randomized (which card gets 'Your Card')
    DrawFormattedText(window, labelStruct{whichPlayer, 1}, ...
        char(labelStruct{whichPlayer, 2}), ... %xcoord
        char(labelStruct{whichPlayer, 3}), ...%ycoord
        labelStruct{whichPlayer, 4}) %color
    
end


end