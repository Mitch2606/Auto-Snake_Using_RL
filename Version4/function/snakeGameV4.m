function [nextObsSnake, nextObsGrader, scoreOut, isDone] = snakeGameV4(Action, reset)

rewardSnake = 0;
showTraining = 1;

timeSteps = 5;

persistent count previousMoveSnake previousMoveGrader rewardBoard score;
persistent snakeBoard appleLoc snakeHead snakeTail snakeLength;

BoardSize = 3;
gameBoard = zeros(BoardSize);

%flags = [HitWall, HitSelf, HitApple];
flags = [0, 0, 0];


if(isempty(rewardBoard)  || (reset == 1))
    rewardBoard = ones(BoardSize);
end

if(isempty(previousMoveSnake) || (reset == 1))
    previousMoveSnake = zeros(1, 17 * timeSteps); 
else
    previousMoveSnake(1:end - 17) = previousMoveSnake(18:end);
end

if(isempty(previousMoveGrader) || (reset == 1))
    previousMoveGrader = zeros(1, 18 * timeSteps);
else
    previousMoveGrader(1:end - 18) = previousMoveGrader(19:end);
end

if(isempty(count) || (reset == 1))
    count = 0;
end

if(isempty(appleLoc) || (reset == 1))
    appleLoc = randi(BoardSize, [1,2]);
    rewardBoard(appleLoc(2), appleLoc(1)) = 10;
end

if(isempty(snakeHead) || (reset == 1))
    snakeHead = [1, 2];
end

if(isempty(snakeTail) || (reset == 1))
    snakeTail = [1, 1];
end

if(isempty(snakeLength) || (reset == 1))
    snakeLength = 2;
end

if(isempty(snakeBoard) || (reset == 1))
    snakeBoard = gameBoard;
end

if(isempty(score) || (reset == 1))
    score = 0;
end

if(count == 0)
    snakeBoard = gameBoard;
    snakeBoard(snakeHead(2), snakeHead(1)) = 1;
    snakeBoard(snakeTail(2), snakeTail(1)) = snakeLength;
    
    score = 0;
end

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

if((sum(find(newHeadLoc >= BoardSize + 1)) >= 1) || (sum(find(newHeadLoc <= 0)) >= 1))%Hit Wall
    flags(1) = 1;
    isDone = 1;
else
    isDone = 0;
end

%Evaluate other conditions
if(isDone == 0)
    if(newHeadLoc == appleLoc)%Hit Apple
        flags(3) = 1;
        
        isDone = 0;
        
        [~, translation] = lookAround(snakeBoard, snakeTail, "searchValue", snakeLength - 1);
        
        snakeBoard(snakeTail(2) + translation(2), snakeTail(1) + translation(1)) = snakeLength;
        
        snakeLength = snakeLength + 1;
        snakeBoard(snakeTail(2), snakeTail(1)) = snakeLength;
        
        newTailLoc = snakeTail;
        
        %Make sure new apple doesn't spawn on Snake
        appleLoc = randi(BoardSize, [1,2]);
        while(snakeBoard(appleLoc(2), appleLoc(1)) ~= 0)
            appleLoc = randi(BoardSize, [1,2]);
        end
        
        
        rewardBoard = ones(BoardSize);
        rewardBoard(appleLoc(2), appleLoc(1)) = 10;
    else
        isDone = 0;
        
        [~, translation] = lookAround(snakeBoard, snakeTail, "searchValue", snakeLength - 1);
        
        snakeBoard(snakeTail(2) + translation(2), snakeTail(1) + translation(1)) = snakeLength;
        
        snakeBoard(snakeTail(2), snakeTail(1)) = 0;
        
        rewardBoard(newHeadLoc(2), newHeadLoc(1)) = 0;
        
        newTailLoc = [snakeTail(1) + translation(1), snakeTail(2) + translation(2)];
    end
else
    newTailLoc = [0,0];
end



if(isDone == 0)
    if(snakeBoard(newHeadLoc(2), newHeadLoc(1)) ~= 0)%Hit itself
        flags(2) = 1;
        isDone = 1;
    else
        snakeBoard(newHeadLoc(2), newHeadLoc(1)) = 1;
    end
end

distanceToApple = real(getDistance(newHeadLoc, appleLoc));

if(isDone == 0)
    if((sum(ismember(gameBoard, 0)) >= 1))
        isDone = 0;
    else
        isDone = 1;
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
    
%     clc
    disp(combinedBoard)
    disp(rewardBoard)
    pause(0.2)
    
end

if(isDone == 0)    
    score = calculateScore(score, flags, count);
    
    directionItsFacing = getDirection(snakeBoard);
    
    [around, ~] = lookAround(snakeBoard, (newHeadLoc));
    %Update What it can see around it
    
    around = updateView(around, directionItsFacing);
    
    %Find Reward
    [rewardAround, ~] = lookAround(rewardBoard, (newHeadLoc));%
    %Update What it can see around it
    
    rewardAround = updateView(rewardAround, directionItsFacing);
    
    previousMove = Action;
    
    nextObsSnake1 = [around, rewardAround, distanceToApple];
    
    previousMoveSnake(end - 16:end) = nextObsSnake1;
    
    nextObsSnake = previousMoveSnake;
    
    %     disp(nextObsSnake)
    
    snakeHead = newHeadLoc;
    snakeTail = newTailLoc;
    
    % nextObsGrader = [score, Action];
    nextObsGrader = [nextObsSnake1, Action];
    
    scoreOut = score;
    
    count = count + 1;
else
%     nextObsSnake = zeros(1,17);
    nextObsSnake = previousMoveSnake;
    nextObsGrader = previousMoveGrader;
    
    scoreOut = score;
end

end














