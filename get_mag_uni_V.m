function [magnitude uniVec] = get_mag_uni_V(vector)
%%this function returns the magnitude and the direction vector from a
%%given vector coordinates
    magnitude = sqrt(vector(1, 1)^2 + vector(1, 2)^2 + vector(1, 3)^2);
    for i = 1: 3
       uniVec(1, i) = vector(1, i)/magnitude; 
    end
end