function abs_Err = calcErr(T_1_0, T_1_new, T_2_0, T_2_new)
    T_1 = T_1_0 - T_1_new;
    T_2 = T_2_0 - T_2_new;
    err = (T_1) - (T_2);
    abs_Err = abs(err);
end