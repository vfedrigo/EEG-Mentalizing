function gameConfig = getCardConfigs(gameConfig, cardConfigDir, maxOutputCount, reGenerate)
gameConfig.gameNum = gameConfig.gameConfigNum * gameConfig.players;

sampleRate = 0.01;

if ~exist(cardConfigDir, 'dir')
   mkdir(cardConfigDir); 
end

configFilename = sprintf('%s/player_%02d_card_%02d_item_%02d.csv', ...
    cardConfigDir, ...
    gameConfig.players, gameConfig.numCardsPerPlayer, ...
    gameConfig.objectNum);
if reGenerate || ~exist(configFilename, 'file')
    configs = [];
    while sampleRate < 2 && size(configs, 1) < maxOutputCount * gameConfig.numCardsPerPlayer * gameConfig.players
        system(sprintf(['cardGameConfigGenerator/cardGameConfigGenerator ', ...
            '-p %d -c %d -i %d -mi %d -mo %d -s %f -o %s'], gameConfig.players, ...
            gameConfig.numCardsPerPlayer, gameConfig.objectNum, ...
            gameConfig.maxObjectCount, maxOutputCount, sampleRate, cardConfigDir));
        configs = csvread(configFilename);
        sampleRate = sampleRate * 2;
    end
else
    configs = csvread(configFilename);
end
outConfigs = zeros(gameConfig.players, gameConfig.numCardsPerPlayer, gameConfig.objectNum, gameConfig.gameNum);
outConfigInfo = zeros(gameConfig.gameNum, 2);
if maxOutputCount < gameConfig.gameConfigNum
    throw(MException('gameConfig pool size is less than required card config num, please regenerate with larger pool size'));
end
[~, configOffsets] = sort(rand(1, maxOutputCount));
configOffsets = configOffsets(1 : gameConfig.gameConfigNum);
for i = 1 : gameConfig.gameConfigNum
    for shiftId = 1 : gameConfig.players
        gameId = (i-1) * gameConfig.players + shiftId;
        shift = shiftId - 1;
        outConfigInfo(gameId, 1) = configOffsets(i);
        outConfigInfo(gameId, 2) = shift;
        for playerId = 1 : gameConfig.players
            shiftedPlayerId = mod(playerId + shift - 1, gameConfig.players) + 1;
           for cardId = 1 : gameConfig.numCardsPerPlayer
              for objectId = 1 : gameConfig.objectNum
                  outConfigs(playerId, cardId, objectId, gameId) = ...
                      configs((configOffsets(i) - 1) * gameConfig.players * gameConfig.numCardsPerPlayer ...
                      + (shiftedPlayerId - 1) * gameConfig.numCardsPerPlayer + cardId, objectId) + 1;
              end
           end
        end
    end
end
[~, randId] = sort(rand(1, gameConfig.gameNum));
gameConfig.cardConfigs = outConfigs(:, :, :, randId);
gameConfig.cardConfigInfo = outConfigInfo(randId, :);

