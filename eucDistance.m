function eD = eucDistance(A, B)
%%this function calculates the distance between two points in space by
%%using the extended Pitagoras theorem
    x1 = A(1, 1);
    x2 = B(1, 1);
    y1 = A(1, 2);
    y2 = B(1, 2);
    z1 = A(1, 3);
    z2 = B(1, 3);
    eD = sqrt((x1 - x2)^2 + (y1 - y2)^2 + (z1 - z2)^2);
end