function updatedView = updateView(view, direction)
% view = [N, NE, E, SE, S, SW, W, NW]
% updatedView = [Forward, FR, R, RightOfBody, Body, LOB, L, FL];

switch(direction)
    case(1) %North
        updatedView = view;
    case(2) %West
        updatedView = [view(end - 1), view(end), view(1:(end - 2))];
    case(3) %South
        updatedView = [view(end - 3:end), view(1:end - 4)];
    case(4) %East
        updatedView = [view(3:end), view(1:2)];
    otherwise
        updatedView = view;
end

end