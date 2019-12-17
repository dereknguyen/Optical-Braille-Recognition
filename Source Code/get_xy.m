function [unique_x, unique_y] = get_xy(intersections)

    unique_x = [];
    unique_y = [];
    
    c = numel(intersections);

    c_x = 1;
    c_y = 1;

    for i = 1:c

        p = intersections{i};

        if ~ismember(p(1), unique_x)
            unique_x(c_x) = p(1);
            c_x = c_x + 1;
        end

        if ~ismember(p(2), unique_y)
            unique_y(c_y) = p(2);
            c_y = c_y + 1;
        end

        plot(p(1,:), p(2,:), 'ro');
    end

    unique_x = sort(unique_x);
    unique_y = sort(unique_y);
end