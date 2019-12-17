function [T_1, T_2] = calcThreshold(maxIndex, hist)

    top = 0;
    bottom = 0;
    
    for i = 1:maxIndex
        top = top + (i * hist(i));
        bottom = bottom + (hist(i));
    end
    
    T_1 = top / bottom;
    
    top = 0;
    bottom = 0;
    
    for i = maxIndex:256
        top = top + (i * hist(i));
        bottom = bottom + (hist(i));
    end
    
    T_2 = top / bottom;
    
end