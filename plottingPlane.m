function plottingPlane(theta, originalMatrix)
f = 10;
[minValX posMinVal] = minimum(originalMatrix(:, 1)-f/2);
[maxValX posMaxVal] = maximum(originalMatrix(:, 1)+f/3);
[minValY posMinVal] = minimum(originalMatrix(:, 2)-f);
[maxValY posMaxVal] = maximum(originalMatrix(:, 2)+f/3);
[minValZ posMinVal] = minimum(originalMatrix(:, 3)-f/3);
[maxValZ posMaxVal] = maximum(originalMatrix(:, 3)+f/3);
A = round(theta(1, 1) * 1e6) / 1e6;
B = round(theta(2, 1) * 1e6) / 1e6;
C = round(theta(3, 1) * 1e6) / 1e6;
D = round(theta(4, 1) * 1e6) / 1e6;

if A ~= 0 && abs(B) < 0.0001 && abs(C) < 0.0001
    [y, z] = meshgrid(minValY: 1: maxValY); % Generate x and y data
    x = -1/A*(B*y + C*z + D); % Solve for z data
    x = round(x * 1e2) / 1e2;
    surf(x, y, z);
elseif abs(A) < 0.0001 && B ~= 0 && abs(C) < 0.0001
    [x, z] = meshgrid(minValZ: 1: maxValZ) % Generate x and y data
    y = -1/B*(A*x + C*z + D); % Solve for z data
    y = round(y * 1e2) / 1e2
    surf(x, y, z);
else
    [x, y] = meshgrid(minValX: 1: maxValX); % Generate x and y data
    z = -1/C*(A*x + B*y + D); % Solve for z data
    z = round(z * 1e2) / 1e2;
    surf(x, y, z) %Plot the surface
end

end
