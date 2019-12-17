function [alpha, beta] = calcParameter(dataset)

    m = mean(dataset);
%     disp('DATASET');
%     disp(dataset);
%     disp('Mean:');
%     disp(m);
    v = var(dataset);
%     disp('Variance:');
%     disp(v);
    
    top_1 = 0;
    bottom_1 = 0;
    top_2 = 0;
    bottom_2 = 0;
    for i = 1:numel(dataset)
        top_1 = top_1 + (dataset(i) * i);
        bottom_1 = bottom_1 + dataset(i);
        
        top_2 = top_2 + (dataset(i) * i^2);
        bottom_2 = bottom_2 + dataset(i);
    end
    
    
    
    m_1 = top_1 / bottom_1;
    m_2 = top_2 / bottom_2;
    
    alpha = m_1 * (m_1 - m_2) / (m_2 - m_1^2);
    beta = (m_1 - 1) * (m_2 - m_1) / (m_2 - m_1^2);
%     alpha = (m * (m - 2 * (m^2) + (m^2) - v + m * v)) / ((m - 1) * v);
%     beta = (m - 2 * (m^2) + (m^3) - v + m * v) / v;

end