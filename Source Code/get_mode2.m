function value = get_mode2(set)
    top = 0;
    bottom = 0;
    
    for i = 1:numel(set)
        top = top + set(i) * i;
        bottom = bottom + set(i);
    end
    
    value = top / bottom;
end