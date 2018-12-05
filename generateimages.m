function subdstRects = generateimages(players)

%This creates partitions inside whichever cards will display, that can be
%filled with the images.

subbaseRect = [150 100 0 0];

subdstRectsTop = nan(4, 6);
subdstRectsTopB = nan(4, 6);
subdstRectsBot = nan(4, 6);
subdstRectsBotB = nan(4, 6);

%Coordinates of where the cards are--if this changes in subsequent makecard
%function, I will change here in a simliar way.
xCoords = [0.10, 0.24, 0.43, 0.57 0.76, 0.90];
yCoords = [0.12, 0.28, 0.72, 0.88];

%Same comment--this will change to be flexible. This is just temporary for
%the current configuration. 
screenXpixels = 1366;
screenYpixels = 768;

if players ~= 4
    for i = 1:length(xCoords)
        subdstRectsTop(:, i) = CenterRectOnPointd(subbaseRect, screenXpixels * xCoords(i), screenYpixels * yCoords(1));
        subdstRectsTopB(:, i) = CenterRectOnPointd(subbaseRect, screenXpixels * xCoords(i), screenYpixels * yCoords(2));
        
    end
end
if players == 6
    for i = 1:length(xCoords)
        subdstRectsBot(:, i) = CenterRectOnPointd(subbaseRect, screenXpixels * xCoords(i), screenYpixels * yCoords(3));
        subdstRectsBotB(:, i) = CenterRectOnPointd(subbaseRect, screenXpixels * xCoords(i), screenYpixels * yCoords(4));
        
    end
end
if players == 5
    for i = 1:4
        subdstRectsBot(:, i) = CenterRectOnPointd(subbaseRect, screenXpixels * xCoords(i), screenYpixels * yCoords(3));
        subdstRectsBotB(:, i) = CenterRectOnPointd(subbaseRect, screenXpixels * xCoords(i), screenYpixels * yCoords(4));
        
    end
elseif players == 4
    for i = 1:4
        specialxCoords = cat(2, xCoords(1:2), xCoords(5:6));
        subdstRectsTop(:, i) = CenterRectOnPointd(subbaseRect, screenXpixels * specialxCoords(i), screenYpixels * yCoords(1));
        subdstRectsTopB(:, i) = CenterRectOnPointd(subbaseRect, screenXpixels * specialxCoords(i), screenYpixels * yCoords(2));
        subdstRectsBot(:, i) = CenterRectOnPointd(subbaseRect, screenXpixels * specialxCoords(i), screenYpixels * yCoords(3));
        subdstRectsBotB(:, i) = CenterRectOnPointd(subbaseRect, screenXpixels * specialxCoords(i), screenYpixels * yCoords(4));
        
    end
end

%Concatenating all of the dstRects for the  images 
subdstRects = cat(2, subdstRectsTop, subdstRectsTopB, subdstRectsBot, subdstRectsBotB);

global windo

%Temporary action--this is just for my own checking that things are going
%where they should. Eventually, here it will draw random images to the
%cards.
Screen('FrameRect', windo, [0 1 0], subdstRects, 6)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% randomindices = [1:(players*2)];
% % make a vector of images & scramble them using these indices
% theImageLocation = ['Spade.png', 'Card Shape.png', 'Card Shape.jpeg']
% theImage = imread(theImageLocation)
% 
% for i = 1:numel(theImageLocation)
%     theImage(numel(i)) = imread(theImageLocation(numel(i)))
%     theImage(numel(i)) = imresize(theImage(numel(i)),[150 NaN]);
% end
% 
% % Make the image into a texture
% imageTexture = Screen('MakeTextures', window, theImage);



end