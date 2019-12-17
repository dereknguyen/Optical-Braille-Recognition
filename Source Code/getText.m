function T = getText(image)

    alph_dir = dir('Alphabet');
    template = getAlphabetTemplate(alph_dir, '.jpg');
  
    I_bw = image;
    I_size = size(image);

    y = round(I_size(1) / 3);
    x = round(I_size(2) / 2);
    
    x_1 = imcrop(I_bw, [0, 0, x, y]);
    x_2 = imcrop(I_bw, [x, 0, x, y]);
    x_3 = imcrop(I_bw, [0, y, x, y]);
    x_4 = imcrop(I_bw, [x, y, x, y]);
    x_5 = imcrop(I_bw, [0, y * 2, x, y]);
    x_6 = imcrop(I_bw, [x, y * 2, x, y]);    
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
    
    letter = 'abcdefghijklmnopqrstuvwxyz';
  
    for i = 1:numel(letter)

        % PRETTY MUCH IF ARRAY MATCH ONE OF TEMPLATE, THAT IS THE
        % LETTER
        if isequal(template{i}, result)
            T = letter(i);
            return;
        end
    end
    
    T = ' ';
    
end