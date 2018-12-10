function labels = makelabels(players)

global windo
[screenXpixels, screenYpixels] = Screen('WindowSize', windo);


Screen('TextSize', windo, 30);
DrawFormattedText(windo, 'Your Cards', screenXpixels * 0.11,...
    screenYpixels * 0.37, [1 0 0]);
Screen('TextSize', windo, 30);
DrawFormattedText(windo, 'Green Player', screenXpixels * 0.78,...
    screenYpixels * 0.37, [0 1 0]);

if players > 3
    Screen('TextSize', windo, 30);
    DrawFormattedText(windo, 'Blue Player', screenXpixels * 0.11,...
        screenYpixels * 0.97, [0 0 1]);
end

if players == 4 || players == 6
    Screen('TextSize', windo, 30);
    DrawFormattedText(windo, 'Pink Player', screenXpixels * 0.77,...
        screenYpixels * 0.97, [1 0 1]);
end

if players == 5 || players == 6 || players == 3
    Screen('TextSize', windo, 30);
    DrawFormattedText(windo, 'Teal Player', screenXpixels * 0.42,...
        screenYpixels * 0.97, [0 1 1]);
end

if players ~= 4 && players ~= 3
    Screen('TextSize', windo, 30);
    DrawFormattedText(windo, 'Grey Player', screenXpixels * 0.42,...
        screenYpixels * 0.37, [0 0 0]);
end
end
