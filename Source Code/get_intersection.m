function x_points = get_intersection(stats, h_line, v_line)

    count = numel(stats) * numel(stats);
    x_points = cell(count, 1);
    n = 1;

    for i = 1:numel(h_line)
        for j = 1:numel(v_line)
            p = InterX(h_line{i}, v_line{j});
            x_points{n} = p;
            n = n + 1;
        end
    end

end