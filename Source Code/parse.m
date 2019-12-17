function [r] = parse(img)

    I = imread(img);
    I_bw = imbinarize(I);
    I_size = size(uint8(I_bw));

    y = round(I_size(1) / 3);
    x = round(I_size(2) / 2);
    
    x_1 = imcrop(I_bw, [0, 0, x, y]);
    x_2 = imcrop(I_bw, [x, 0, x, y]);
    x_3 = imcrop(I_bw, [0, y, x, y]);
    x_4 = imcrop(I_bw, [x, y, x, y]);
    x_5 = imcrop(I_bw, [0, y * 2, x, y]);
    x_6 = imcrop(I_bw, [x, y * 2, x, y]);

%     figure;
%     subplot(1, 6, 1); imshow(x_1);
%     subplot(1, 6, 2); imshow(x_2);
%     subplot(1, 6, 3); imshow(x_3);
%     subplot(1, 6, 4); imshow(x_4);
%     subplot(1, 6, 5); imshow(x_5);
%     subplot(1, 6, 6); imshow(x_6);
    
    
    set = {x_1, x_2, x_3, x_4, x_5, x_6};
    
    result = zeros(1, 6);

    for x = 1:numel(set)
        
        % GET MEAN VALUE OF ALL PIXEL
        m = mean(set{x}, 'all');
        
        % IF MEAN IS NOT BLACK, IT MEANS THERE IS A WHITE DOT.
        if m > 0.01
            result(x) = 1;
        end
    end
%     
%     disp(result);
%     pause
    r = result;
end