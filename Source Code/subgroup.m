function [mode_1, mode_2, mode_3] = subgroup(hist, T_1, T_2)
    mode_1 = hist(1:T_1);
    mode_2 = hist((T_1 + 1):T_2);
    mode_3 = hist((T_2 + 1):end);
end