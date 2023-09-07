function [midx midy midz] = get_mid_point(p1, p2)
%%this function returns the middle point coordinates between two given
%%points
    midx = (1/2)*(p1(1, 1) + p2(1, 1));
    midy = (1/2)*(p1(1, 2) + p2(1, 2));
    midz = (1/2)*(p1(1, 3) + p2(1, 3));    
end