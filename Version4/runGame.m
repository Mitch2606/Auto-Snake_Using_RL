maxSteps = 1000;

nextObs = zeros(1,17 * 5);
auto = 0;
isDone = 0;

figure
for i = 1: maxSteps
    if(auto == 0)
        Action = input("[F, L, R]: ");
    else
        Action = getAction(Paul, nextObs);
        Action = Action{1};
    end
    
    
    [nextObs, ~, scoreOut, isDone] = snakeGameV3(Action, isDone);
    
    currentObs = nextObs(end-16:end);
    
    A = [currentObs(8), currentObs(1:2); currentObs(7), 0, currentObs(3); flip(currentObs(4:6))]
    B = [currentObs(16), currentObs(9:10); currentObs(15), 0, currentObs(11); flip(currentObs(12:14))]

    imagesc(A)
    
    %     C = currentObs(end)
    
    if(isDone == 1)
        title("YOU DIED!!")
        break;
    end
    
end
