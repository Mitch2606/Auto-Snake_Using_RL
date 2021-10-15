


epochs = 100;

figure
hold on
grid on

env = rlSimulinkEnv("rlPlaysSnake", "rlPlaysSnake/Paul");

train = 0;

for i = 1: epochs
    if(train == 1)
        trainStats = train(Paul, env);
        break
    else
        a = sim("rlPlaysSnake");
        
        score = a.Reward;
        
        plot(score, "lineWidth", 2)
        
        drawnow
    end
end

    
    
    
