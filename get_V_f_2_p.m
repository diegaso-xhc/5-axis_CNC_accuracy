function vector = get_V_f_2_p(p1, p2)
%%This function returns a vector from two given points. The direction will
%%be p1 to p2
    vector = zeros(size(1,3));
    for i = 1: 3
       vector(1, i) = p1(1, i) - p2(1, i); 
    end
end