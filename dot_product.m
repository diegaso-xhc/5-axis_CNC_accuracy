function dp = dot_product(vector1, vector2)
    dp = 0;
    for i = 1: 3
        dp = dp + vector1(1, i)*vector2(1, i);
    end
end