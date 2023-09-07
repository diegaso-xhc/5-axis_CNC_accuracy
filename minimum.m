function [minVal, position] = minimum(vector)
%%This function finds the minimum value among the values within an array
    minVal = vector(1, 1);
    position = 1;
    for i = 1: size(vector, 1)
       if vector(i, 1) < minVal
           minVal = vector(i, 1);
           position = i;
       end
    end
end