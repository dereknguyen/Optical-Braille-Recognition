function mean = calcMean(dataset)
    sum = 0;
    for i = 1:numel(dataset)
        sum = sum + dataset(i);
    end
    mean = sum / numel(dataset);
end