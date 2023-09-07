function circularity = getCircularityValue(excelPoints)

    %%%%%%%%%%%%%%%%%%%%%Reading of the XYZ_Data file%%%%%%%%%%%%%%%%%%%%%%%%%%
    originalRawMatrix = excelPoints(:, 1:3);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%Histogram of initial values%%%%%%%%%%%%%%%%%%%%%%%%%%%
    histogramRawVectorX = histogramFunction(originalRawMatrix(:, 1));
    histogramRawVectorY = histogramFunction(originalRawMatrix(:, 2));
    histogramRawVectorZ = histogramFunction(originalRawMatrix(:, 3));
    figure;
    subplot(3, 2, 1)
    bar(histogramRawVectorX(:, 1), histogramRawVectorX(:, 2), 0.25, 'g');
    title('X values Histogram');
    xlabel('X values in [mm]');
    ylabel('Number of points');
    subplot(3, 2, 3)
    bar(histogramRawVectorY(:, 1), histogramRawVectorY(:, 2), 0.25, 'b');
    title('Y values Histogram');
    xlabel('Y values in [mm]');
    ylabel('Number of points');
    subplot(3, 2, 5)
    bar(histogramRawVectorZ(:, 1), histogramRawVectorZ(:, 2), 0.25, 'r');
    title('Z values Histogram');
    xlabel('Z values in [mm]');
    ylabel('Number of points');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%Using the Gradient Descendent in order to find the plane Equation%%%%%%
    J = 0;
    theta = randn(4, 1);
    iterations = 250000;
    alpha = 0.0001;
    iter = 0;
    originalRawMatrix(:, 4) = 1; 
    n = size(originalRawMatrix, 1);
    alpha = alpha / n;
    for i = 1: iterations
        h = originalRawMatrix * theta;    
        theta = theta - alpha * originalRawMatrix' * h;
        J = h'*h;
        if J < 0.0000000005 
            break;
        end
    end

    for i = 1: size(originalRawMatrix, 1)
       error(i, 1) =  theta(1,1) * originalRawMatrix(i, 1) + theta(2,1) * originalRawMatrix(i, 2) + theta(3,1) * originalRawMatrix(i, 3) + theta(4, 1);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%Getting the Standard Deviation%%%%%%%%%%%%%%%%%%%%%%%%%
    mean = 0;
    stDev = 0;
    for i = 1: size(originalRawMatrix, 1)
       errorValue = theta(1,1) * originalRawMatrix(i, 1) + theta(2,1) * originalRawMatrix(i, 2) + theta(3,1) * originalRawMatrix(i, 3) + theta(4, 1);
       stDev = stDev + (errorValue - mean)*(errorValue - mean);
    end
    stDev = sqrt(stDev / size(originalRawMatrix, 1));
    validDatum = 0;
    numStDev = 3;
    suplimit = mean + numStDev * stDev;
    inflimit = mean - numStDev * stDev;
    for i = 1: size(originalRawMatrix, 1)
       if error(i, 1) <= suplimit && error(i, 1) >= inflimit  
            validDatum = validDatum + 1;   
       end
    end
    originalMatrix = zeros(validDatum, 3);
    j = 0;
    for i = 1: size(originalRawMatrix, 1)
        if error(i, 1) <= suplimit && error(i, 1) >= inflimit
            j = j + 1;
            originalMatrix(j, 1) = originalRawMatrix(i, 1);
            originalMatrix(j, 2) = originalRawMatrix(i, 2);
            originalMatrix(j, 3) = originalRawMatrix(i, 3);
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%Histogram of final values%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    histogramVectorX = histogramFunction(originalMatrix(:, 1));
    histogramVectorY = histogramFunction(originalMatrix(:, 2));
    histogramVectorZ = histogramFunction(originalMatrix(:, 3));
    subplot(3, 2, 2)
    bar(histogramVectorX(:, 1), histogramVectorX(:, 2), 0.25, 'g');
    title('X values Histogram');
    xlabel('X values in [mm]');
    ylabel('Number of points');
    subplot(3, 2, 4)
    bar(histogramVectorY(:, 1), histogramVectorY(:, 2), 0.25, 'b');
    title('Y values Histogram');
    xlabel('Y values in [mm]');
    ylabel('Number of points');
    subplot(3, 2, 6)
    bar(histogramVectorZ(:, 1), histogramVectorZ(:, 2), 0.25, 'r');
    title('Z values Histogram');
    xlabel('Z values in [mm]');
    ylabel('Number of points');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%Sorting the data for finding all of the possible centers%%%%%%%%%
    ranges = size(originalMatrix, 1)/3;
    index = zeros(1, size(originalMatrix, 1));
    for i = 1: int16(ranges)
        index(1, 3*i - 2) = i; 
        index(1, 3*i - 1) = int16(ranges) + i;
        index(1, 3*i) = 2*int16(ranges) + i;    
    end
    index(1, size(originalMatrix, 1)) = size(originalMatrix, 1);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%Creating Matrices for storing the corresponding data%%%%%%%%%%%
    newOrderMatrix = zeros(size(originalMatrix, 1) + 2, 3);
    %newOrderMatrix = zeros(size(originalMatrix, 1), 3);
    centerMatrix = zeros(size(originalMatrix, 1), 3);
    noneAssValMatrix = zeros(size(originalMatrix, 1), 3);
    distanceVector = zeros(size(originalMatrix, 1), 1);
    genericp = zeros(1, 3);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%Asigning the data from the original Matrix to a new order%%%%%
    %%%%%%%%%%%%%Matrix according to the sorting way chosen in the%%%%%%%%%%%%%
    %%%%%%%%%%%%%initializing_program file%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for  i = 1: size(originalMatrix,1)
        for j = 1: 3
            newOrderMatrix(i, j) = originalMatrix(index(1, i), j);
        end
    end
    for j = 1: 3
        newOrderMatrix(size(originalMatrix,1) + 1, j) = newOrderMatrix(1, j);
        newOrderMatrix(size(originalMatrix,1) + 2, j) = newOrderMatrix(2, j);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%Choosing three points iteratively for the center coordinates%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%calculation%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    p1 = zeros(1, 3);
    p2 = zeros(1, 3);
    p3 = zeros(1, 3);

    for i = 1: size(originalMatrix,1)
        for j = 1: 3
            p1(1, j) = newOrderMatrix(i, j);
            p2(1, j) = newOrderMatrix(i + 1, j);
            p3(1, j) = newOrderMatrix(i + 2, j);
        end
        [centerMatrix(i, 1), centerMatrix(i, 2), centerMatrix(i, 3)] = get_center(p1, p2, p3);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    %In some cases there are points which are repated. Therefore the resulting
    %center coordinates in an iteration in which two points are exactly the
    %same, will be a non-assigned value (NaN). This is the reason why we need
    %to filter these missing center coordinates by using the function isnan
    noneAssValMatrix = isnan(centerMatrix);
    xc = 0;
    yc = 0;
    zc = 0;
    numValidCenters = 0;

    for i = 1: size(originalMatrix,1)
        if noneAssValMatrix(i, :) ~= [1 1 1]
            numValidCenters = numValidCenters + 1;
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %We reorganize the valid center coordinates from the original Center Matrix
    %into a new matrix containing only the valid coordinates without
    %non-assigned values
    validCenters = zeros(numValidCenters, 3);
    k = 0;
    for i = 1: size(originalMatrix,1)
        if noneAssValMatrix(i, :) ~= [1 1 1]
            k = k + 1;
            for j = 1: 3
                validCenters(k, j) = centerMatrix(i, j);
            end
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%Getting the Standard Deviation%%%%%%%%%%%%%%%%%%%%%%%%%
    centerMeanX = 0;
    centerMeanY = 0;
    centerMeanZ = 0;

    for i = 1: size(validCenters, 1)
       centerMeanX = centerMeanX + validCenters(i, 1); 
       centerMeanY = centerMeanY + validCenters(i, 2); 
       centerMeanZ = centerMeanZ + validCenters(i, 3); 
    end

    centerMeanX = centerMeanX / size(validCenters, 1);
    centerMeanY = centerMeanY / size(validCenters, 1);
    centerMeanZ = centerMeanZ / size(validCenters, 1);

    centerStDevX = 0;
    centerStDevY = 0;
    centerStDevZ = 0;

    for i = 1: size(validCenters, 1)
        centerStDevX = centerStDevX + (validCenters(i, 1) - centerMeanX)*(validCenters(i, 1) - centerMeanX);
        centerStDevY = centerStDevY + (validCenters(i, 2) - centerMeanY)*(validCenters(i, 2) - centerMeanY);
        centerStDevZ = centerStDevZ + (validCenters(i, 3) - centerMeanZ)*(validCenters(i, 3) - centerMeanZ);
    end

    centerStDevX = sqrt(centerStDevX / size(validCenters, 1));
    centerStDevY = sqrt(centerStDevY / size(validCenters, 1));
    centerStDevZ = sqrt(centerStDevZ / size(validCenters, 1));

    numCenterStDev = 3;

    centerSuplimitX = centerMeanX + numCenterStDev * centerStDevX;
    centerInflimitX = centerMeanX - numCenterStDev * centerStDevX;
    centerSuplimitY = centerMeanY + numCenterStDev * centerStDevY;
    centerInflimitY = centerMeanY - numCenterStDev * centerStDevY;
    centerSuplimitZ = centerMeanZ + numCenterStDev * centerStDevZ;
    centerInflimitZ = centerMeanZ - numCenterStDev * centerStDevZ;

    xcounter = 0;
    ycounter = 0;
    zcounter = 0;

    for i = 1: size(validCenters, 1)
        if validCenters(i, 1) <= centerSuplimitX && validCenters(i, 1) >= centerInflimitX
            xc = xc + validCenters(i, 1);
            xcounter = xcounter + 1;
        end
        if validCenters(i, 2) <= centerSuplimitY && validCenters(i, 2) >= centerInflimitY
            yc = yc + validCenters(i, 2);
            ycounter = ycounter + 1;
        end
        if validCenters(i, 3) <= centerSuplimitZ && validCenters(i, 3) >= centerInflimitZ
            zc = zc + validCenters(i, 3);
            zcounter = zcounter + 1;
        end
    end

    xc = xc / xcounter;
    yc = yc / ycounter;
    zc = zc / zcounter;
    center = [xc yc zc];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %We compute the distance from the average center to each of the points in
    %the Excel file so that we can know the maximum radius and the minimum
    %radius
    for i = 1: size(originalMatrix,1)
        genericp = newOrderMatrix(i,:);
        distanceVector(i, 1) = eucDistance(center, genericp);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Results%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [maxV, imax] = maximum(distanceVector);
    [minV, imin] = minimum(distanceVector);
    circularity = maxV - minV;
    pmax = newOrderMatrix(imax, :);
    pmin = newOrderMatrix(imin, :);
    standardDesviation = std(validCenters);
    covariance = cov(validCenters);
    figure;
    plot3(newOrderMatrix(:, 1), newOrderMatrix(:, 2), newOrderMatrix(:, 3), '.r', 'MarkerSize', 15)
    title('Recorded points during 5-axis CNC motion','FontSize',16);
    xlabel('X [mm]');
    ylabel('Y [mm]');
    zlabel('Z [mm]');
    grid off
    hold on
    pbaspect([1,1,1]);
    axis('square');
    plottingPlane(theta, originalMatrix);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end