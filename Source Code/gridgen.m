function [h_line, v_line, stats] = gridgen(im, x_diff, y_diff, s_ax)
    
    im_gray = rgb2gray(im);
    im_bw = ~imbinarize(im_gray);
    im_size = size(im_bw);
    cc = bwconncomp(im_bw);
    bw = bwareafilt(im_bw, cc.NumObjects);
    stats = regionprops(cc, 'Centroid', 'EquivDiameter');
   
    subplot(s_ax); imshow(bw); 
    
    centroids_array = vertcat(stats.Centroid);
    [~, sortindx] = sort(centroids_array(:,1));
    stats = stats(sortindx);
    
    h_line = cell(numel(stats), 1);
    v_line = cell(numel(stats), 1);
    
    x_coord = []; count_x = 1; 
    y_coord = []; count_y = 1; 

    
    for x = 1:numel(stats)

        similar_x = 0;
        similar_y = 0;

        c = stats(x).Centroid;
        radius = stats(x).EquivDiameter / 2;

        y_1 = round(c(2) - radius);     
        x_1 = round(c(1) - radius); 

        for i = 1:numel(x_coord)
            if abs(x_coord(i) - x_1) < x_diff && abs(x_coord(i) - x_1) ~= 0
                similar_x = 1;
                break;
            end
        end

        for i = 1:numel(y_coord)
            if abs(y_coord(i) - y_1) < y_diff && abs(y_coord(i) - y_1) ~= 0
                similar_y = 1;
                break;
            end
        end

        if similar_x == 0
            x_coord(count_x) = x_1;
            count_x = count_x + 1;
            line([x_1, x_1], [0, im_size(1)], 'LineWidth', 1.0);
            l_1 = [x_1 x_1; 0 im_size(1)];
            h_line{x} = l_1;
        end

        if similar_y == 0
            y_coord(count_y) = y_1;
            count_y = count_y + 1;
            line([0, im_size(2)], [y_1, y_1], 'LineWidth', 1.0);
            l_2 = [0 im_size(2); y_1 y_1];
            v_line{x} = l_2;
        end
    end
    
    emptyCells = cellfun('isempty', h_line); 
    h_line(all(emptyCells,2),:) = [];

    emptyCells = cellfun('isempty', v_line); 
    v_line(all(emptyCells,2),:) = [];
    
end
