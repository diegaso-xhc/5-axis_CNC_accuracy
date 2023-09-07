function [maxVal, position] = maximum(vector)
%%This function finds the maximum value among the values within an array
    maxVal = vector(1, 1);
    position = 1;
    for i = 1: size(vector, 1)
       if vector(i, 1) > maxVal
           maxVal = vector(i, 1);
           position = i;
       end
    end
end