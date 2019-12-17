close all;
clear, clc;

% I = rgb2gray(imread('pokemon_ruby.png'));
% I_bw = ~im2bw(I, 0.4);
% imshow(~I_bw);

I = uint8(imread('test.png'));
I_bw = ~imbinarize(I);
imageSize = size(I);

whiteImage = 255 * ones(imageSize(1), imageSize(2), 'uint8');


CC = bwconncomp(I_bw);
BW = bwareafilt(I_bw, CC.NumObjects);
stats = regionprops(CC, 'Centroid');
r = regionprops(CC, 'EquivDiameter');

area = regionprops(CC, 'Area');


% figure; 

% hold on
for i = 1:numel(stats)
    c = stats(i).Centroid;
    radius = (r(1).EquivDiameter / 2) * 1.0;
    x = c(1);
    y = c(2);
    whiteImage = insertShape(whiteImage,'FilledCircle',[x y radius],'LineWidth',5, 'Opacity', 1, 'Color', 'Black');
end
% hold off
% imshow(whiteImage);

I = rgb2gray(whiteImage);
I_bw = ~imbinarize(I);
imageSize = size(I);

CC = bwconncomp(I_bw);
BW = bwareafilt(I_bw, CC.NumObjects);
stats = regionprops(CC, 'Centroid');
r = regionprops(CC, 'EquivDiameter');

cents = vertcat(stats.Centroid);
[~, sorty] = sort(cents(:,1));
stats = stats(sorty);

centroids = cat(1, stats.Centroid);

figure;
imshow(BW)
hold on

s = stats;

p = [];
n = numel(s);
horzLine = cell(n, 1);
vertLine = cell(n, 1);

x_coord = [];
y_coord = [];

count_x = 1;
count_y = 1;

similar_x = 0;
similar_y = 0;

for x = 1:numel(s)
    
    similar_x = 0;
    similar_y = 0;
    
    c = s(x).Centroid;
    radius = r(x).EquivDiameter / 2;

    y_1 = round(c(2) - radius);     
    x_1 = round(c(1) - radius); 
    y_2 = round(c(2) + radius);     
    x_2 = round(c(1) + radius); 
    
    for i = 1:numel(x_coord)
        if abs(x_coord(i) - x_1) < 5 && abs(x_coord(i) - x_1) ~= 0
            similar_x = 1;
            break;
        end
    end
    
    for i = 1:numel(y_coord)
        if abs(y_coord(i) - y_1) < 5 && abs(y_coord(i) - y_1) ~= 0
            similar_y = 1;
            break;
        end
    end
    
    if similar_x == 0
        x_coord(count_x) = x_1;
        count_x = count_x + 1;
        line3 = line([x_1, x_1], [0, imageSize(1)]);
        l_1 = [x_1 x_1; 0 imageSize(1)];
        horzLine{x} = l_1;
    end
    
    if similar_y == 0
       
        y_coord(count_y) = y_1;
        count_y = count_y + 1;
        
        line1 = line([0, imageSize(2)], [y_1, y_1]);
%         line1 = line([0, imageSize(2)], [y_2, y_2]);

        


%         l_1 = [x_1 x_1; 0 imageSize(1)];
        l_2 = [0 imageSize(2); y_1 y_1];


%         horzLine{x} = l_1;
        vertLine{x} = l_2;
    end
end
pause


emptyCells = cellfun('isempty', horzLine); 
horzLine(all(emptyCells,2),:) = [];

emptyCells = cellfun('isempty', vertLine); 
vertLine(all(emptyCells,2),:) = [];

count = numel(s) * numel(s);
points = cell(count, 1);
n = 1;

for i = 1:numel(horzLine)
    for j = 1:numel(vertLine)
        p = InterX(horzLine{i}, vertLine{j});
        points{n} = p;
        n = n + 1;
  
    end
end

 

c = count;
for j = 1:c
    poi = points{j};
    if ~isempty(poi)
        for k = j + 1:c
            if ~isempty(points{k})
                p_x = points{k}(1);
                p_y = points{k}(2);
                poi_x = poi(1);
                poi_y = poi(2);

                pd_x = percentDif(p_x, poi_x);
                pd_y = percentDif(p_y, poi_y);
                
                disp(pd_x);
                disp(pd_y);

                if pd_x < 0.3 && pd_y < 0.3
                    points{k} = [];
                end
            end
        end
    end
end

emptyCells = cellfun('isempty', points); 
points(all(emptyCells,2),:) = [];


unique_x = [];
unique_y = [];
prev_x = 0;
prev_y = 0;

c = numel(points);

c_x = 1;
c_y = 1;

for i = 1:c
    
    p = points{i};
    
    if ~ismember(p(1), unique_x)
        unique_x(c_x) = p(1);
        c_x = c_x + 1;
    end
    
    if ~ismember(p(2), unique_y)
        unique_y(c_y) = p(2);
        c_y = c_y + 1;
    end
    
    plot(p(1,:), p(2,:), 'ro');
end



x = sort(unique_x);
y = sort(unique_y);


[x_l, x_s] = difPoints(x);
[y_l, y_s] = difPoints(y);


p_x = removeX(x, x_s);
p_y = y(1:3:end);
hold off


% letter = 'abcdefghijklmnopqrstuvwxyz';

mkdir('Cropped');
addpath('Cropped');
cr_dir = dir('Cropped');
dir_str = cr_dir.folder;
count = 1;
for i = 1:numel(p_y)
    for j = 1:numel(p_x)
        x = p_x(j);
        y = p_y(i);
        width = x_s * 2.5;
        height = y_s * 3;
%         crop = imcrop(BW, [x, y, width, height]);
%         imname = strcat(dir_str, '/', num2str(count), '.jpg');
%         imwrite(crop, imname);
%         count = count + 1;
        rectangle('Position', [x y width height], 'LineWidth', 1, 'EdgeColor', 'g');
    end
end


function p = percentDif(x, y)
    p = 100 * abs((x - y) / x);
end

function [l, s] = difPoints(x)
    s = intmax('uint64');
    l = 0;
  
    x_c = 2;

    while x_c <= numel(x)
        dif_x = x(x_c) - x(x_c - 1);

        if s > dif_x && dif_x > 2
            s = dif_x;
        end

        if l < dif_x
            l = dif_x;
        end

        x_c = x_c + 1;
    end
end

function [p] = removeX(x, len)
    x_c = 2;

    while x_c <= numel(x)
        dif_x = x(x_c) - x(x_c - 1);
%         disp('TEST');
%         disp(x(x_c));
%         disp(x(x_c - 1))
%         disp(dif_x);
%         disp(len);
        per = percentDif(len, dif_x);
%         disp(per);
        if per < 70 
            x(x_c) = [];
        end

        x_c = x_c + 1;
    end
    p = x;
end

function [p] = removeY(y, len)
    x_c = 2;

    to_remove = [];
    count = 1;
    while x_c <= numel(y)
        per = percentDif(len, y(x_c) - y(x_c - 1));
%         disp(per);
        if per > 10 
            to_remove(count) = x_c;
%             disp(x_c);
            count = count + 1;
        end
        
        x_c = x_c + 1;
    end
    
%     disp(to_remove);
    
    for x = 1:numel(to_remove)
        l = to_remove(x);
        if x > 1
           l = l - x;
        end
        disp(y(l));
        y(l) = [];
     
    end
    p = y;
end