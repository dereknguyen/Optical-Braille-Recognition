function v = calcVariance(dataset, mean)
    sum = 0;
    for i = 1:numel(dataset)
        sum = sum + (dataset(i)^2);
    end
    v = (sum / numel(dataset)) - mean^2;
end