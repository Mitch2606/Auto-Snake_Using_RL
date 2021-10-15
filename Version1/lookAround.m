function [around, optionalReturns] = lookAround(matrix, startPoint, varargin)
%LOOKAROUND Summary of this function goes here
%   Detailed explanation goes here

searchValue = 0;
for i = 1: 2 : length(varargin)
    parm = lower(varargin{i});
    value = varargin{i + 1};
    switch(parm)
        case("searchvalue")
            searchValue = value;
        otherwise
            disp("Parm: " + parm + " | Doesn't Exist")
    end
end

pointer = flip([startPoint(1) + 0, startPoint(2) - 1]);

good = checkPointer(size(matrix), pointer);

if(good == 1)
    N = matrix(pointer(1), pointer(2));
else
    N = 0;
end

pointer = flip([startPoint(1) + 1, startPoint(2) - 1]);
good = checkPointer(size(matrix), pointer);
if(good == 1)
    NE = matrix(pointer(1), pointer(2));
else
    NE = 0;
end

pointer = flip([startPoint(1) + 1, startPoint(2) + 0]);
good = checkPointer(size(matrix), pointer);
if(good == 1)
    E = matrix(pointer(1), pointer(2));
else
    E = 0;
end

pointer = flip([startPoint(1) + 1, startPoint(2) + 1]);
good = checkPointer(size(matrix), pointer);
if(good == 1)
    SE = matrix(pointer(1), pointer(2));
else
    SE  = 0;
end

pointer = flip([startPoint(1) + 0, startPoint(2) + 1]);
good = checkPointer(size(matrix), pointer);
if(good == 1)
    S = matrix(pointer(1), pointer(2));
else
    S = 0;
end

pointer = flip([startPoint(1) - 1, startPoint(2) + 1]);
good = checkPointer(size(matrix), pointer);
if(good == 1)
    SW = matrix(pointer(1), pointer(2));
else
    SW = 0;
end

pointer = flip([startPoint(1) - 1, startPoint(2) + 0]);
good = checkPointer(size(matrix), pointer);
if(good == 1)
    W = matrix(pointer(1), pointer(2));
else
    W = 0;
end

pointer = flip([startPoint(1) - 1, startPoint(2) - 1]);
good = checkPointer(size(matrix), pointer);
if(good == 1)
    NW = matrix(pointer(1), pointer(2));
else
    NW  = 0;
end
around = [N, NE, E, SE, S, SW, W, NW];

if(searchValue ~= 0)
    location = find(around == searchValue);
    
    if(isempty(location) == 0)
        switch(location)
            case(1)%N
                optionalReturns = [0, -1];
            case(2)%NE
                optionalReturns = [1, -1];
            case(3)%E
                optionalReturns = [1, 0];
            case(4)%SE
                optionalReturns = [1, 1];
            case(5)%S
                optionalReturns = [0, 1];
            case(6)%SW
                optionalReturns = [-1, 1];
            case(7)%W
                optionalReturns = [-1, 0];
            case(8)%NW
                optionalReturns = [-1, -1];
            otherwise
                optionalReturns = [0, 0];
        end
    else
        optionalReturns = [0, 0];
    end
else
    optionalReturns = [0, 0];
end




end

