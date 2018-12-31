function [cardWidth, cardHeight, cardXPositions, labelYPosition, labelWidth, labelHeight] = getCardParameters(numCardsPerPlayer, cardAspectRatio, cardGapRelative, ...
    sectionMarginRelative, sectionWidth, sectionHeight)

sectionMargin = floor(sectionMarginRelative * min(sectionWidth, sectionHeight));
cardGap = floor(cardGapRelative * min(sectionWidth, sectionHeight));

maxCardHeight = sectionHeight - 2 * sectionMargin;
maxCardWidth = floor((sectionHeight - 2 * sectionMargin + cardGap) / numCardsPerPlayer - cardGap);

if maxCardHeight > maxCardWidth * cardAspectRatio
    cardHeight = floor(maxCardWidth * cardAspectRatio);
    cardWidth = maxCardWidth;
else
    cardHeight = maxCardHeight;
    cardWidth = floor(cardHeight / cardAspectRatio);
end

totalCardWidth = cardWidth * numCardsPerPlayer + cardGap * (numCardsPerPlayer - 1);
cardXPositions = [cardWidth / 2 : cardWidth + cardGap : totalCardWidth - cardWidth / 2] - (totalCardWidth / 2);
labelYPosition = cardHeight / 2 + sectionMargin / 2;
labelWidth = sectionWidth;
labelHeight = sectionMargin;

