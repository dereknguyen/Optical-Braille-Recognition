function [r] = getAlphabetTemplate(alphabet_dir, kind)
    
    % Letter is just to build image path
    letter = 'abcdefghijklmnopqrstuvwxyz';
    
    r = cell(numel(letter), 1);
    
    % start at 3 to skip over the . and .. directory
    for x = 3 : 1 : numel(alphabet_dir)
        
        % Reseting back to 1
        index = x - 2;
        
        % Don't worry about this, this is just build path to image.
        dir = strcat(alphabet_dir(x).folder);           
        imname = strcat(letter(index), kind);    
        im_path = strcat(dir, '/', imname);               
        
        % Calling parse function to parse crop image into logical array.
        % Then store it into a cells of array.
        r{index} = parse(im_path);
        
    end
end