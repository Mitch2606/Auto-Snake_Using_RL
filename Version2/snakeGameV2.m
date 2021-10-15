function [nextObs, reward, isDone] = snakeGameV2(Action, reset)

reward = 0;
showTraining = 0;

persistent count previousMove rewardBoard;
persistent snakeBoard appleLoc snakeHead snakeTail snakeLength;

BoardSize = 5;
gameBoard = zeros(BoardSize);

if(isempty(rewardBoard)  || (reset == 1))
    rewardBoard = ones(BoardSize);
end

if(isempty(previousMove) || (reset == 1))
    previousMove = 0;
end

if(isempty(count) || (reset == 1))
    count = 0;
end

if(isempty(appleLoc) || (reset == 1))
    appleLoc = randi(BoardSize, [1,2]);
end

if(isempty(snakeHead) || (reset == 1))
    snakeHead = [3, 4];
end

if(isempty(snakeTail) || (reset == 1))
    snakeTail = [3, 5];
end

if(isempty(snakeLength) || (reset == 1))
    snakeLength = 2;
end

if(isempty(snakeBoard) || (reset == 1))
    snakeBoard = gameBoard;
end


if(count == 0)
    snakeBoard = gameBoard;
    snakeBoard(snakeHead(2), snakeHead(1)) = 1;
    snakeBoard(snakeTail(2), snakeTail(1)) = snakeLength;
    
    score = 0;
end
% imshow(combinedBoard)

% imagesc(gameBoard)
% title("Score: " + score)

% Action = input("Pick a Direction [N, E, S, W]");

directionItsFacing = getDirection(snakeBoard);

%Find Direction and translation array
N = [ 0, -1];
S = [ 0,  1];
E = [ 1,  0];
W = [-1,  0];

switch(directionItsFacing)
    case(1) %North
%         translationArray = [Forward, Left, Right]
        translationArray = [N; W; E];
    case(2) %West
        translationArray = [W; S; N];
    case(3) %South
        translationArray = [S; E; W];
    case(4) %East
        translationArray = [E; N; S];
    otherwise
        translationArray = zeros(3,2);
end

%Perform Action
newHeadLoc = snakeHead + translationArray(Action, :);

%Evaluate other conditions
if(newHeadLoc == appleLoc)%Hit Apple
    reward = reward + 10;
    isDone = 0;
    
    [~, translation] = lookAround(snakeBoard, snakeTail, "searchValue", snakeLength - 1);
    
    snakeBoard(snakeTail(2) + translation(2), snakeTail(1) + translation(1)) = snakeLength;
    
    snakeLength = snakeLength + 1;
    snakeBoard(snakeTail(2), snakeTail(1)) = snakeLength;
    
    newTailLoc = snakeTail;
    
    appleLoc = randi(BoardSize, [1,2]);
    
    rewardBoard = ones(BoardSize);
else
    isDone = 0;
    reward = reward + 0;
    
    disp(snakeBoard)
    
    [~, translation] = lookAround(snakeBoard, snakeTail, "searchValue", snakeLength - 1);
    
    snakeBoard(snakeTail(2) + translation(2), snakeTail(1) + translation(1)) = snakeLength;
    
    snakeBoard(snakeTail(2), snakeTail(1)) = 0;
    
    newTailLoc = [snakeTail(1) + translation(1), snakeTail(2) + translation(2)];
end

if((sum(find(newHeadLoc >= BoardSize)) >= 1) || (sum(find(newHeadLoc <= 0)) >= 1))%Hit Wall
    isDone = 1;
    reward = reward - 10;
end

if(isDone == 0)
    if(snakeBoard(newHeadLoc(2), newHeadLoc(1)) ~= 0)%Hit itself
        isDone = 1;
        reward = reward - 10;
    else
        snakeBoard(newHeadLoc(2), newHeadLoc(1)) = 1;
%         reward = reward + 1;
    end
end



distanceToApple = real(getDistance(newHeadLoc, appleLoc));

if(isDone == 0)
    if((sum(ismember(gameBoard, 0)) >= 1))
        isDone = 0;
        
        reward = reward + rewardBoard(newHeadLoc(2), newHeadLoc(1));
        rewardBoard(newHeadLoc(2), newHeadLoc(1)) = 0;
        
%         reward = reward + 1;
    else
        isDone = 1;
        reward = reward + 100;
    end
end

%Adjust All the other values
if(isDone == 0)
    searchNumber = 1;
    startPoint = newHeadLoc;
    while(searchNumber ~= snakeLength)
        [~, translation] = lookAround(snakeBoard, startPoint, "searchvalue", searchNumber);
        if(translation == [0,0])
            break;
        end
        
        startPoint = startPoint + translation;
        
        searchNumber = searchNumber + 1;
        
        snakeBoard(startPoint(2), startPoint(1)) = searchNumber;
        
    end
end



if(showTraining == 1)
    gameBoard(appleLoc(2), appleLoc(1)) = -1;
    
    combinedBoard = gameBoard + snakeBoard;
    
    clc
    disp(combinedBoard)
    pause(0.2)
    
end

[around, ~] = lookAround(snakeBoard, newHeadLoc);
[rewardAround, ~] = lookAround(rewardBoard, newHeadLoc);

previousMove = Action;

nextObs = [around, rewardAround, distanceToApple];
snakeHead = newHeadLoc;
snakeTail = newTailLoc;

count = count + 1;
end














