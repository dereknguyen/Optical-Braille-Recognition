function [l, s] = difPoints(x)
    s = intmax('uint64');
    l = 0;
  
    x_c = 2;

    while x_c <= numel(x)
        dif_x = x(x_c) - x(x_c - 1);

        if s > dif_x && dif_x > 2
            s = dif_x;
        end

        if l < dif_x
            l = dif_x;
        end

        x_c = x_c + 1;
    end
end