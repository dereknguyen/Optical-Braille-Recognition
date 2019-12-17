function x_points = remove_repeat(stats, points, x_diff, y_diff)

    count = numel(stats) * numel(stats);
    
    for j = 1 : count
        poi = points{j};
        
        if ~isempty(poi)
            
            for k = j + 1 : count
                
                if ~isempty(points{k})
                    p_x = points{k}(1);
                    p_y = points{k}(2);
                    poi_x = poi(1);
                    poi_y = poi(2);
                    pd_x = per_diff(p_x, poi_x);
                    pd_y = per_diff(p_y, poi_y);                    
                    if pd_x < x_diff && pd_y < y_diff
                        points{k} = [];
                    end
                end
            end
        end
    end
    
    emptyCells = cellfun('isempty', points); 
    points(all(emptyCells,2),:) = [];
    
    x_points = points;
    
end