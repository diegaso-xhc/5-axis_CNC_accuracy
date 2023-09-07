function cosine = coslaw(p1, p2, p3, l, originalMatrix)
    cosine = (originalMatrix(p1, 1) - originalMatrix(p2, 1))^2 + (originalMatrix(p1, 2) - originalMatrix(p2, 2))^2 + (originalMatrix(p1, 3) - originalMatrix(p2, 3))^2 + (originalMatrix(p3, 1) - originalMatrix(p1, 1))^2 + (originalMatrix(p3, 2) - originalMatrix(p1, 2))^2 + (originalMatrix(p3, 3) - originalMatrix(p1, 3))^2 - l^2;
    cosine = cosine / sqrt(((originalMatrix(p1, 1) - originalMatrix(p2, 1))^2 + (originalMatrix(p1, 2) - originalMatrix(p2, 2))^2 + (originalMatrix(p1, 3) - originalMatrix(p2, 3))^2)*((originalMatrix(p3, 1) - originalMatrix(p1, 1))^2 + (originalMatrix(p3, 2) - originalMatrix(p1, 2))^2 + (originalMatrix(p3, 3) - originalMatrix(p1, 3))^2));
    cosine = cosine / 2;
end