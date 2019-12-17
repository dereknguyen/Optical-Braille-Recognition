function [I, stats] = bwrebuild(I_bw, r_scale, pdiff_area)
% BWREBUILD  Rebuild segmented image by filling out uneven Braille dots.

   
    im_size = size(I_bw);
    I = 255 * ones(im_size(1), im_size(2), 'uint8');
    
    % Perform connected component
    cc = bwconncomp(I_bw);
    disp(cc);
    stats = regionprops(cc, 'Centroid', 'EquivDiameter', 'Area');
    disp(stats);
    
    % Get the smallest area
    areas = vertcat(stats.Area);
    smallest_area = min(areas);
    
    % Iterate through the detected components 
    %   to remove noise that was picked up as a 
    %   braille dot.
    for i = 1:numel(stats)
        
        c = stats(i).Centroid;
        radius = (stats(1).EquivDiameter / 2) * r_scale;
        area = stats(i).Area;
        
        % Check if the area is similar to the smallest area by
        %   user specified percent.
        perdif = per_diff(area, smallest_area);
        
        % If it is more than user specified percent,
        %   it is not a noise.
        if perdif > pdiff_area
            x = c(1);
            y = c(2);
        
            % Insert circle to image.
            I = insertShape(I,'FilledCircle',[x y radius], ...
                                'LineWidth', 5, ...
                                'Opacity', 1, ...
                                'Color', 'Black');
        end
    end
    
    
end