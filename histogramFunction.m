function histVector = histogramFunction(Vector)
    histogram = zeros(size(Vector, 1), 2);
    [sizeHistZ, histogram] = getHistogramSize(Vector);
    histVector = zeros(sizeHistZ, 2);
    
    for j = 1: sizeHistZ
        for i = 1: size(Vector, 1)
            if (histogram(i, 1) ~= 0)
                histVector(j, 1) = histogram(i, 1);
                histVector(j, 2) = histogram(i, 2);
                histogram(i, 1) = 0;
                histogram(i, 2) = 0;
                break;
            end
        end
    end    
end