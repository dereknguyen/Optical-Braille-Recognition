function [p] = removeX(x, len)
    x_c = 2;

    while x_c <= numel(x)
        dif_x = x(x_c) - x(x_c - 1);
        per = per_diff(len, dif_x);
        if per < 70 
            x(x_c) = [];
        end

        x_c = x_c + 1;
    end
    p = x;
end