function cardChoice = recordclick(window, sectionCenter, cardXPositions, cardHeight, cardWidth)

[~, clickX, clickY] = GetClicks(window);

clickXOffset = clickX - sectionCenter(1);
[minXOffset, cardChoice] = min(abs(clickXOffset - cardXPositions));
clickYOffset = clickY - sectionCenter(2);
if abs(clickYOffset) > cardHeight / 2 || minXOffset > cardWidth / 2
    cardChoice = -1;
    %waitfor(errordlg('Please click within the RED RECTANGLE BOUNDARIES and select one of your cards', 'Invalid Click'));
    return;
end