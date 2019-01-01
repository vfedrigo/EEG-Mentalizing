function [userId, userExist] = renderLoginPage(window, width, height, userDataPath, gameDataFilename)
borderWidth = 6;

DrawFormattedText(window, 'Input New User ID to Login\n\n Press Enter to Confirm, Press E for Existing User', 'center', round(height / 4), 0); 
        
inputBoxSize = [0, 0, round(width / 2), round(height /8)];
inputBoxRect = CenterRectOnPointd(inputBoxSize, width / 2, height / 2);
Screen('FrameRect',window, [127, 127, 127], inputBoxRect, borderWidth);
userId = GetEchoString(window, '[New User ID:]', inputBoxRect(1) + borderWidth * 2,...
    inputBoxRect(2) + borderWidth * 2, 0, [255, 255, 255]);
userExist = exist(sprintf('%s/%s/%s', userDataPath, userId, gameDataFilename), 'file');
Screen('Flip', window);
end
