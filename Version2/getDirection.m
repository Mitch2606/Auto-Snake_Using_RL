function [direction] = getDirection(matrix)
%GETDIRECTION Summary of this function goes here
%   Detailed explanation goes here

[x, y] = find(matrix == 1); %HeadLoc
locP1 = [x, y];

[x, y] = find(matrix == 2); %Last Body segment
locP2 = [x, y];

difference = locP1 - locP2;

if(difference == [-1, 0])
    direction = 1; %N
elseif(difference == [0, -1])
    direction = 2; %W
elseif(difference == [1, 0])
    direction = 3; %S
elseif(difference == [0, 1])
    direction = 4; %E
else
    direction = 0; %Error
    disp("Something Broke!")
end

end

