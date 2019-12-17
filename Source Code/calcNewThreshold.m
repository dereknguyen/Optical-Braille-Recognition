function T = calcNewThreshold(A, B, C, T_0)
    T = 1 - exp((-A - B * log(T_0)) / C);
end