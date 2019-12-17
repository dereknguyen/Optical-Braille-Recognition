function p = calcProbability(dataset, hist)

    top = 0;
    bottom = 0;

    for i = 1:numel(dataset)
        top = top + dataset(i);
    end
    
    for i = 1:numel(hist)
        bottom = bottom + hist(i);
    end
    
    p = top / bottom;
end