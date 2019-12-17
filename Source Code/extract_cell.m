function extract_cell(im, x, y, directory, is_demo, ...
   cell_width_scale, cell_height_scale, ax, im_og)
    
    [~, x_s] = difPoints(x);
    [~, y_s] = difPoints(y);
    
    p_x = removeX(x, x_s);
    p_y = y(1:3:end);
    
    dir_str = directory.folder;
    count = 1;
    
    subplot(ax), imshow(im_og);
    
    for i = 1:numel(p_y)
        for j = 1:numel(p_x)
            x = p_x(j);
            y = p_y(i);
            width = x_s * cell_width_scale;
            height = y_s * cell_height_scale;
            
            if ~is_demo
                crop = ~(imcrop(im, [x, y, width, height]));
                imname = strcat(dir_str, '/', num2str(count), '.jpg');
                imwrite(crop, imname);
                count = count + 1;
            else
                crop = ~(imcrop(im, [x, y, width, height]));
                T = getText(crop);               
                text(x, y + (height / 2), T, 'FontSize', 50, 'FontWeight', 'bold', 'Color', 'red');
                rectangle('Position', [x y width height], ... 
                          'LineWidth', 1, ...
                          'EdgeColor', 'g');
            end
        end
    end
   
end