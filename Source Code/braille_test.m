close all;
clear, clc;

% figure;

is_demo = 1;
mkdir('Cropped');
addpath('Cropped');
addpath('Alphabet');
cr_dir = dir('Cropped');
test_image = 'test.png';

% USER SET PARAMTERS
%==========================================================================
rebuild_radius_scale = 1.0;
rebuild_percent_dif_area = -1;
pixel_dif_x = 5;
pixel_dif_y = 5;
intx_per_dif_x = 0.3;
intx_per_dif_y = 0.3;
cell_width_scale = 2;
cell_height_scale = 3;
%==========================================================================

%
% Example Run
%


% IMAGE PRE-PROCESSING
%==========================================================================
% [1] Read in braille image
i_og = imread('pokemon_ruby.png');
i_gray = rgb2gray(i_og);
i_norm = mat2gray(i_gray);
s = size(i_norm);

% [2] Filter Image 
k = fspecial('gaussian', [5 5], 0.6);
i_filt = imfilter(i_norm, k);

%==========================================================================


% IMAGE SEGMENTATION
%==========================================================================
% [3] Threshold image
otsu = graythresh(i_filt);
BW = imbinarize(i_filt, otsu);
rect = [2 3 (s(2) - 3) (s(1) - 4)];
im = ~(imcrop(BW, rect));
%==========================================================================

% IMAGE ENHANCING
%==========================================================================
% [4] Rebuild image
im_new = bwrebuild(im, rebuild_radius_scale, rebuild_percent_dif_area);
subplot(2, 2, 1); imshow(im_new); 
%==========================================================================

ax = subplot(2, 2, 2); hold on;

% FEATURE EXTRACTION 
%==========================================================================
% [5] Generate Grid
% figure; imshow(im_new);
% pause;
[h_line, v_line, stats] = gridgen(im_new, pixel_dif_x, pixel_dif_y, ax);

% [6] Get intersection
intersections = get_intersection(stats, h_line, v_line);


% [7] Remove repeating intersection
intersections = remove_repeat(stats, intersections, ...
                              intx_per_dif_x, intx_per_dif_y);

% [8] Obtain the unique X and Y location of intersections
[x, y] = get_xy(intersections);
%==========================================================================
hold off;

ax_2 = subplot(2, 2, [3 4]); 
hold on;
% BRAILLE CELL DETECTION
%==========================================================================
% [9] Extract region of interest for translation
extract_cell(im_new, x, y, cr_dir, is_demo, ...
             cell_width_scale, cell_height_scale, ax_2, i_og);
%==========================================================================
hold off;

if ~is_demo
% GENERATE ALPHABET TEMPLATE
%==========================================================================
alph_dir = dir('Alphabet');
template = getAlphabetTemplate(alph_dir, '.jpg');
%==========================================================================


% DECODE CROPPED AREA OF INTEREST
%==========================================================================
img_dir = dir('Cropped');
r = decode(template, img_dir, '.jpg');
disp(r);
%==========================================================================
end