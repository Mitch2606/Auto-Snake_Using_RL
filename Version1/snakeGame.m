BoardSize = 10;
gameBoard = zeros(BoardSize);

appleLocation = [8, 5];

gameBoard(appleLocation(2), appleLocation(1)) = 5;

snakeLocations = [2, 5; 3,5];

score = 0;

figure
hold on
while(sum(ismember(gameBoard, 0)) >= 1)
    
    gameBoard = zeros(BoardSize);
    gameBoard(appleLocation(2), appleLocation(1)) = 5;
    gameBoard(snakeLocations(:,2), snakeLocations(:,1)) = 3;
    

    imagesc(gameBoard)
    title("Score: " + score)
    
    Action = input("Pick a Direction [N, E, S, W]");
    
    %Perform Action
    switch(Action)
        case(1) %N
            snakeLocations = [[snakeLocations(1,1), snakeLocations(1,2) + 1]; snakeLocations];
        case(2) %E
            snakeLocations = [[snakeLocations(1,1) + 1, snakeLocations(1,2)]; snakeLocations];
        case(3) %S
            snakeLocations = [[snakeLocations(1,1), snakeLocations(1,2) - 1]; snakeLocations];
        case(4) %W
            snakeLocations = [[snakeLocations(1,1) - 1, snakeLocations(1,2)]; snakeLocations];
        otherwise
            fprintf("\nMake a move")
    end
    
    %Evaluate failure conditions
    snakeLocations
    
    newHeadLoc = [snakeLocations(1,1), snakeLocations(1,2)];
    for i = 1: size(snakeLocations, 1)
        if((sum(sum(ismember(snakeLocations, newHeadLoc))) > 1) || (sum(ismember(newHeadLoc, 0)) >= 1) || (sum(ismember(newHeadLoc, BoardSize + 1)) >= 1))
            failed = 1;
            isDone = 1;
        else
            failed = 0;
            isDone = 0;
        end
    end
    
    distanceToApple = getDistance(newHeadLoc, appleLocation);
    
    if(newHeadLoc == appleLocation) 
        score = score + 1;
        appleLocation = randi(BoardSize, 1, 2);
    else
        snakeLocations(end, :) = [];
    end
end

isDone = 1;

