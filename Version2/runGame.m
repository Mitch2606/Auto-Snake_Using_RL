maxSteps = 1000;

nextObs = zeros(1,17);
auto = 1;
isDone = 0;



for i = 1: maxSteps
    if(auto == 0)
        Action = input("[F, L, R]: ");
    else
        Action = getAction(Paul, nextObs);
        Action = Action{1};
    end
    
    
    [nextObs, reward, isDone] = snakeGameV2(Action, isDone);
    
%     if(isDone == 1)
%         break;
%     end
    
end
