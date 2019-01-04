//
//  main.cpp
//  cardGameConfigGenerator
//
//  Created by Li Xiaomin on 12/29/18.
//  Copyright © 2018 Li Xiaomin. All rights reserved.
//

#include <iostream>
#include <vector>
#include <unordered_set>
#include <stdlib.h>

int solutionId = 0;
int minUsedItem = 0;
int itemMaxUsedCount = 0;
int l3MaxOverlap = 1;
char filename[80];
const char* outputDir = ".";
FILE* fid;
bool isVerbose;
float sampleRate;

int getPayoff(std::vector<int> &choice1, std::vector<int> &choice2) {
    int i = 0, j = 0;
    int score = 0;
    while(i < choice1.size() && j < choice2.size()) {
        while(i < choice1.size() && choice1[i] < choice2[j]) i++;
        while(j < choice2.size() && choice2[j] < choice1[i]) j++;
        if(choice1[i] == choice2[j]) {
            i++;
            j++;
            score++;
        }
    }
    return score;
}

std::vector<int> getPayoffs(std::vector<std::vector<int>> &state, int offset, int cardNum,
                            std::vector<int> &config) {
    std::vector<int> payoffs(cardNum, 0);
    for(int i = 0; i< cardNum; i++) {
        payoffs[i] = getPayoff(state[offset + i], config);
    }
    return payoffs;
}

int getBestOptionCount(std::vector<std::vector<int>> &state, int targetOffset,
                       int sourceOffset, int cardNum, int itemNum, bool isStrict) {
    std::vector<std::vector<int>> payoffs(cardNum);
    for(int i = 0; i < cardNum; i++) {
        payoffs[i] = getPayoffs(state, targetOffset, cardNum, state[sourceOffset + i]);
    }
    std::vector<int> maxPayoffs(cardNum, 0);
    for (int i = 0; i < cardNum; i++) {
        for(int j = 0; j < cardNum; j++) {
            if(payoffs[i][j] == itemNum) {
                return -1;
            }
            if(payoffs[i][j] > maxPayoffs[j]) {
                maxPayoffs[j] = payoffs[i][j];
            }
        }
    }
    
    int bestOptionNum = 0;
    for(int i = 0; i< cardNum; i++) {
        bool isBestOption = !isStrict;
        for(int j = 0; j< cardNum; j++) {
            if(payoffs[i][j] < maxPayoffs[j] && !isStrict) {
                isBestOption = false;
                break;
            } else if(payoffs[i][j] >= maxPayoffs[j] && isStrict) {
                isBestOption = true;
                break;
            }
        }
        if (isBestOption) {
            bestOptionNum ++;
        }
    }
    
    if (isStrict) {
        return bestOptionNum == 1 ? 1 : 0;
    } else {
        return bestOptionNum;
    }
}

int getPlayerItemCount(std::vector<std::vector<int>> &state, int offset, int cardNum, int objectNum) {
    std::unordered_set<int> usedItems;
    for (int i = 0; i< cardNum; i++) {
        for ( int j = 0; j < objectNum; j++) {
            usedItems.insert(state[offset + i][j]);
        }
    }
    return (int)usedItems.size();
}

int getItemMaxUsedCount(std::vector<std::vector<int>> &state, int size, int maxItemCount) {
    int maxCount = 0;
    std::vector<int> usedCount(maxItemCount, 0);
    for (int i = 0; i < size; i++) {
        for (int j = 0 ; j < state[i].size(); j++) {
            usedCount[state[i][j]]++;
            maxCount = maxCount > usedCount[state[i][j]] ? maxCount : usedCount[state[i][j]];
        }
    }
    return maxCount;
}

bool isEndingPhaseValid(std::vector<std::vector<int>> &state, int offset, int cardNum, int itemNum) {
    return getBestOptionCount(state, 0, offset, cardNum, itemNum, true) == 1;
}

bool isMiddlePhaseValid(std::vector<std::vector<int>> &state, int prevOffset, int nextOffset, int cardNum, int itemNum) {
    return getBestOptionCount(state, nextOffset, prevOffset, cardNum, itemNum, false) == 0;
}

bool l3heuristic(std::vector<std::vector<int>> &state, int offset, int maxOverlap, int cardNum) {
    for(int i = 0; i < cardNum; i++) {
        for (int j = 0; j < cardNum; j++) {
            if(getPayoff(state[offset - cardNum * 3 + i], state[offset - cardNum]) > 1) {
                return false;
            }
        }
    }
    return true;
}

int fillInNextCardConfig(std::vector<int> &prevConfig, std::vector<int> &nextConfig,
                         int usedItemNum, int maxItemCount) {
    int pivot = -1;
    for(int i = int(prevConfig.size()) - 1 ; i >=0 ; i--) {
        if(prevConfig[i] < usedItemNum &&
           prevConfig[i] + int(prevConfig.size()) - 1 - i < maxItemCount) {
            pivot = i;
            break;
        }
    }
    if (pivot < 0) {
        return -1;
    }
    for(int i = 0 ; i < nextConfig.size(); i++) {
        if (i < pivot) {
            nextConfig[i] = prevConfig[i];
        } else if (i == pivot){
            nextConfig[i] = prevConfig[i] + 1;
        } else {
            nextConfig[i] = nextConfig[i -1] + 1;
        }
    }
    
    return usedItemNum > nextConfig[nextConfig.size() -1] + 1 ?
    usedItemNum : nextConfig[nextConfig.size() - 1] + 1;
}

void searchForValidGameConfig(int playerNum, int cardNum, int itemNum, int maxItemCount,
                              int usedItemNum, std::vector<std::vector<int>> &state,
                              int searchStep,
                              int maxOutputCount) {
    if (solutionId >= maxOutputCount) {
        return;
    }
    int nextUsedItemNum = usedItemNum;
    if( searchStep % cardNum == 0 ) {
        if (getItemMaxUsedCount(state, searchStep, maxItemCount) > itemMaxUsedCount) {
            return;
        }
        // if we are dealing with a new player
        if (searchStep >= cardNum && getPlayerItemCount(state, searchStep - cardNum, cardNum, itemNum) <= minUsedItem) {
            return;
        }
        if (searchStep >= cardNum * 2 && !isMiddlePhaseValid(state, searchStep - 2 * cardNum, searchStep - cardNum, cardNum, itemNum)) {
            return;
        }
        // heuristic 3
        if (searchStep >= cardNum * 3 && !l3heuristic(state, searchStep, l3MaxOverlap, cardNum)) {
            return;
        }
        if(searchStep == playerNum * cardNum) {
            // finished generating all players' card
            if (isEndingPhaseValid(state, playerNum * cardNum - cardNum, cardNum, itemNum)) {
                if ( RAND_MAX * sampleRate < rand() % RAND_MAX) {
                    return;
                }
                if (isVerbose) {
                    printf("Solution %d:\n", solutionId);
                    for (int i = 0; i < playerNum; i++) {
                        printf("\tPlayer %d: \n", i);
                        for (int j = 0; j < cardNum; j++) {
                            printf("\t\tCard %d: ", j);
                            for(int k = 0; k < itemNum; k++) {
                                printf("%d ", state[i * cardNum + j][k]);
                            }
                            printf("\n");
                        }
                    }
                }
                for (int i = 0; i < playerNum; i++) {
                    for (int j = 0; j < cardNum; j++) {
                        for(int k = 0; k < itemNum; k++) {
                            fprintf(fid, "%d", state[i * cardNum + j][k]);
                            if (k < itemNum - 1) {
                                fprintf(fid, ", ");
                            }                        }
                        fprintf(fid, "\n");
                    }
                }
                solutionId++;
            }
            return;
        }
        for (int i = 0; i < itemNum; i++) {
            state[searchStep][i] = i;
        }
        nextUsedItemNum = usedItemNum > itemNum ? usedItemNum : itemNum;
    } else {
        // if we are not dealing with a new player
        nextUsedItemNum = fillInNextCardConfig(state[searchStep - 1], state[searchStep],
                                               usedItemNum, maxItemCount);
    }
    while(nextUsedItemNum >= 0) {
        searchForValidGameConfig(playerNum, cardNum, itemNum, maxItemCount, nextUsedItemNum, state, searchStep + 1, maxOutputCount);
        nextUsedItemNum = fillInNextCardConfig(state[searchStep], state[searchStep], usedItemNum, maxItemCount);
    }
}

void printValidGameConfig(int playerNum, int cardNum, int itemNum, int maxItemCount,
                          int maxOutputCount, float sampleRateIn, bool verbose) {
    isVerbose = verbose;
    sampleRate = sampleRateIn;
    sprintf(filename, "%s/player_%02d_card_%02d_item_%02d.csv", outputDir, playerNum, cardNum, itemNum);
    std::vector<std::vector<int>> state(playerNum * cardNum);
    for(int i = 0; i < playerNum * cardNum; i++) {
        state[i] = std::vector<int>(itemNum);
    }
    
    fid = fopen(filename, "w");
    searchForValidGameConfig(playerNum, cardNum, itemNum, maxItemCount, 0, state, 0,
                             maxOutputCount);
    fclose(fid);
}

int main(int argc, const char * argv[]) {
    if (argc < 2) {
        printf("Usage:\n\t[-p]: playerNum (default: 6)\n\t[-c]: cardNum (default: 2)\n\t[-i]: itemNum (default: 2)\n\t[-mi]: maxItemCount (default: 7)\n\t[-mo] maxOutputCount (default: 20)\n\t[-v]: verbose (default: false)\n\t[-s]: sampleRate (default: 1.0)\n\t[-o]: outputDir\n");
        return 0;
    }
    
    int playerNum = 6;
    int cardNum = 2;
    int itemNum = 3;
    int maxItemCount = 7;
    int maxOutputCount = 20;
    int l3MaxOverlapIn = 1;
    int minUsedItemCount = 0;//cardNum * (itemNum - 1);
    int itemMaxUsed = playerNum * cardNum;
    float sampleRate = 0.05f;
    bool verbose = false;
    for(int i = 1; i < argc; i+= 2) {
        if(strcmp(argv[i], "-p") == 0) {
            playerNum = std::stoi(argv[i + 1]);
        } else if (strcmp(argv[i], "-c") == 0) {
            cardNum = std::stoi(argv[i + 1]);
        } else if (strcmp(argv[i], "-i") == 0) {
            itemNum = std::stoi(argv[i + 1]);
        } else if (strcmp(argv[i], "-mi") == 0) {
            maxItemCount = std::stoi(argv[i + 1]);
        } else if (strcmp(argv[i], "-mo") == 0) {
            maxOutputCount = std::stoi(argv[i + 1]);
        } else if (strcmp(argv[i], "-v") == 0) {
            verbose = true;
            i--;
        } else if (strcmp(argv[i], "-s") == 0) {
            sampleRate = std::stof(argv[i + 1]);
        } else if (strcmp(argv[i], "-o") == 0) {
            outputDir = argv[i + 1];
        } else if (strcmp(argv[i], "-mu") == 0) {
            minUsedItemCount = std::stoi(argv[i + 1]);
        } else if (strcmp(argv[i], "-mui") == 0) {
            itemMaxUsed = std::stoi(argv[i + 1]);
        } else if (strcmp(argv[i], "-mui") == 0) {
            l3MaxOverlapIn = std::stoi(argv[i + 1]);
        }
    }
    minUsedItem = minUsedItemCount;
    itemMaxUsedCount = itemMaxUsed;
    l3MaxOverlap = l3MaxOverlapIn;
    
    printValidGameConfig(playerNum, cardNum, itemNum, maxItemCount, maxOutputCount, sampleRate, verbose);
    return 0;
}
