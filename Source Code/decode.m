function [r] = decode(alpha_template, img_dir, kind)

    letter = 'abcdefghijklmnopqrstuvwxyz';
    
    for x = 3 : 1 : numel(img_dir)
        
        index = x - 2;
        
        dir = strcat(img_dir(x).folder);           
        imname = strcat(num2str(index), kind);    
        imdir = strcat(dir, '/', imname);
       
%         figure; imshow(imread(imdir));
        result = parse(imdir);
%         
%         disp(result);
    
        
        for i = 1:numel(letter)
            
            % PRETTY MUCH IF ARRAY MATCH ONE OF TEMPLATE, THAT IS THE
            % LETTER
            if isequal(alpha_template{i}, result)
                r(index) = letter(i);
            end
        end
    end
    
end