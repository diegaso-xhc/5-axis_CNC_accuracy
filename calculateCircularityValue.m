clear all
close all
clc

excelPoints = xlsread('.\CNC_data\CalcCircAfter.xls');
count = 0;
for i = length(excelPoints): -1: 1
    if (excelPoints(i, 1) == excelPoints(i - 1, 1) && excelPoints(i, 2) == excelPoints(i - 1, 2) && excelPoints(i, 3) == excelPoints(i - 1, 3))
        count = count + 1;        
    else
        break;
    end
end
count = length(excelPoints) - count;
excelPoints = excelPoints(1: count, :); 
circularity = getCircularityValue(excelPoints)
