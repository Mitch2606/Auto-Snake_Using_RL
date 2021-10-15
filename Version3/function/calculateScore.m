function [score] = calculateScore(score, flags, count)

if(sum(flags(1:2)) >= 1)
    score = 0;
else
    score = score + ((1 / (count + 1)) + 10 * flags(3));
end

end

