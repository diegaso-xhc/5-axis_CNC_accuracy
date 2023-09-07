function [sizeHist, histogram] = getHistogramSize(Vector)

    histogram = zeros(size(Vector, 1), 2);
    
    for i = 1: size(Vector, 1)
        histogram(i, 1) = Vector(i, 1); 
        for j = 1: size(Vector, 1)
           if (Vector(i, 1) ==  Vector(j, 1))
                histogram(i, 2) = histogram(i, 2) + 1;            
           end
        end
        for j = 1: size(Vector, 1)
           if (i ~= j)
              if (histogram(i, 1) ==  histogram(j, 1))
                    histogram(i, 1) = 0;
              end 
           end       
        end 
    end
    
    sizeHist = 0;
    
    for i = 1: size(Vector, 1)
        if (histogram(i, 1) ~= 0)
            sizeHist = sizeHist + 1;
        end
    end
end