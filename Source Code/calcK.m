function K = calcK(alpha_0, alpha_1, beta_0, beta_1)
    top = gamma(alpha_0 - beta_0);
    bottom = gamma(alpha_1 - beta_1);
    K = top / bottom;
end