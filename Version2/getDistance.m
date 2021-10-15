function distance = getDistance(point1, point2)

xErr = point2(1,1) - point1(1,1);
yErr = point2(1,2) - point1(1,2);

distance = sqrt(xErr^2 + yErr^2);

end