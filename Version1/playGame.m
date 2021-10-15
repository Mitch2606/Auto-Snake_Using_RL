function [nextObs, reward, count, snakeBoard, appleLoc, isDone, snakeHead, snakeTail, snakeLength] = ...
    playGame(Action, count, snakeBoard, appleLoc, snakeHead, snakeTail, snakeLength)

BoardSize = 5;
gameBoard = zeros(BoardSize);

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

%Perform Action
switch(Action)
    case(1) %N
        newHeadLoc =  snakeHead + [0, 1];
    case(2) %E
        newHeadLoc =  snakeHead + [1, 0];
    case(3) %S
        newHeadLoc =  snakeHead + [0, -1];
    case(4) %W
        newHeadLoc =  snakeHead + [-1, 0];
    otherwise
        fprintf("\nMake a move")
end

%Evaluate other conditions

if(newHeadLoc == appleLoc)%Hit Apple
    reward = 1;
    isDone = 0;
    
    [~, translation] = lookAround(snakeBoard, snakeTail, "searchValue", snakeLength - 1);
    
    snakeBoard(snakeTail(2) + translation(2), snakeTail(1) + translation(1)) = snakeLength;
    
    snakeLength = snakeLength + 1;
    snakeBoard(snakeTail(2), snakeTail(1)) = snakeLength;
    
    newTailLoc = snakeTail;
else
    isDone = 0;
    reward = 0;
    
    disp(snakeBoard)
    
    [~, translation] = lookAround(snakeBoard, snakeTail, "searchValue", snakeLength - 1);
    
    snakeBoard(snakeTail(2) + translation(2), snakeTail(1) + translation(1)) = snakeLength;
    
    snakeBoard(snakeTail(2), snakeTail(1)) = 0;
    
    newTailLoc = [snakeTail(1) + translation(1), snakeTail(2) + translation(2)];
end

if((sum(ismember(newHeadLoc, BoardSize + 1)) >= 1) || (sum(ismember(newHeadLoc, 0)) >= 1))%Hit Wall
    isDone = 1;
    reward = -10;
end

if(isDone == 0)
    if(snakeBoard(newHeadLoc(2), newHeadLoc(1)) ~= 0)%Hit itself
        isDone = 1;
        reward = -10;
    else
        snakeBoard(newHeadLoc(2), newHeadLoc(1)) = 1;
    end
end



distanceToApple = getDistance(newHeadLoc, appleLoc);
if(isDone == 0)
    if((sum(ismember(gameBoard, 0)) >= 1))
        isDone = 0;
        reward = 0;
    else
        isDone = 1;
        reward = 100;
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

combinedBoard = gameBoard + snakeBoard;

disp(combinedBoard)

nextObs = distanceToApple;
snakeHead = newHeadLoc;
snakeTail = newTailLoc;

count = count + 1;
end

