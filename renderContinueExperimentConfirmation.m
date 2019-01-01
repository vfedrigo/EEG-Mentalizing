function shouldContinue = renderContinueExperimentConfirmation(window)

DrawFormattedText(window, ['User Id already exists. Continue with Existing User?\n\n',...
    'Press Y to Continue\n',... 
    'Press N to return to Login Page'], ...
    'center', 'center', 0);
Screen('Flip', window);

keyboardInput = GetChar;
while keyboardInput ~= 'n' && keyboardInput ~= 'N' &&...
    keyboardInput ~= 'y' && keyboardInput ~= 'Y'
    keyboardInput = GetChar;
end

shouldContinue = keyboardInput == 'y' || keyboardInput == 'Y';
