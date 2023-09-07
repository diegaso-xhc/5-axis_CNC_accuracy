function cpVector = cross_product(vector1, vector2)
    %%This function performs the cross product between two vectors and
    %%returns a new vector
    cpVector = zeros(size(1, 3));
    cpVector(1, 1) = vector1(1, 2)*vector2(1, 3) - vector1(1, 3)*vector2(1, 2);
    cpVector(1, 2) = vector1(1, 3)*vector2(1, 1) - vector1(1, 1)*vector2(1, 3);
    cpVector(1, 3) = vector1(1, 1)*vector2(1, 2) - vector1(1, 2)*vector2(1, 1); 
end