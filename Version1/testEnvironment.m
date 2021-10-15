


count = 0;
snakeBoard = zeros(5);
appleLoc = [1,3];
snakeHead = [2, 2];
snakeTail = [2, 3];
snakeLength = 2;
isDone = 0;

figure
h = [];
while(~isDone)
    Action = input("Move [N, E, S, W]");
    
    [nextObs, reward, count, snakeBoard, appleLoc, isDone, snakeHead, snakeTail, snakeLength] = ...
        playGame(Action, count, snakeBoard, appleLoc, snakeHead, snakeTail, snakeLength);
    h = [h, isDone];
    plot(h)
    count = count + 1;
end






