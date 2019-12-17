close all;
clear, clc;
format longG

i_og = imread('ss_scanned_2.png');
figure; imshow(i_og);
i_gray = rgb2gray(i_og);
i_norm = mat2gray(i_gray);

k = fspecial('gaussian', [5 5], 0.6);
i_filt = imfilter(i_norm, k);

figure; imshow(i_filt);

s = size(i_norm);


figure
imhist(i_filt); ylim([0 10000]);


rosin = RosinThreshold(imhist(i_filt));

disp(rosin / 255);
otsu = graythresh(i_filt);
disp(otsu)

avg = ((otsu * 255) + rosin) / 2;
disp(avg / 255);
BW = imbinarize(i_filt, otsu);

figure;

rect = [2 3 (s(2) - 3) (s(1) - 4)];
crop = imcrop(BW, rect);

imshow(crop);
imwrite(crop, 'test.png');
% 
% i = im2single(i_gray);
% labels = imsegkmeans(i, 3);



% mask = 2 == labels;
% cluster = bsxfun(@times, i, cast(mask, class(i)));
% imshow(i);

% figure('Name', 'Original Scan'); 
% imshow(i_og); 
% figure('Name', 'Grayscale Scan'); 
% imshow(i_gray);  

% figure;
% imhist(i_norm);
% [counts, grayLevels] = imhist(i_gray);
% % bar(grayLevels, counts, 'BarWidth', 1);
% 
% [max_value, max_index] = max(counts);
% 
% % INITIAL THRESHOLD
% [T_1, T_2] = calcThreshold(max_index, counts);
% 
% T_1 = round(T_1);
% T_2 = round(T_2);
% 
% [group_1_0, group_2_0, group_3_0] = subgroup(counts, T_1, T_2);
% % [mode_1_0, i_1] = get_mode(group_1_0);
% % [mode_2_0, i_2] = get_mode(group_2_0);
% % [mode_3_0, i_3] = get_mode(group_3_0);
% 
% % [a_1, b_1] = calcParameter(mode_1_0, mode_2_0);
% % [a_2, b_2] = calcParameter(mode_2_0, mode_3_0);
% 
% [a_1_0, b_1_0] = calcParameter(group_1_0);
% [a_2_0, b_2_0] = calcParameter(group_2_0);
% [a_3_0, b_3_0] = calcParameter(group_3_0);
% % 
% p_1 = calcProbability(group_1_0, counts);
% p_2 = calcProbability(group_2_0, counts);
% p_3 = calcProbability(group_3_0, counts);
% 
% K_1_0 = calcK(a_1_0, a_2_0, b_1_0, b_2_0);
% K_2_0 = calcK(a_2_0, a_3_0, b_2_0, b_3_0);
% 
% K_1_0(isnan(K_1_0))=0;
% K_2_0(isnan(K_2_0))=0;
% 
% A_1 = calcA(p_1, K_1_0, p_2, K_2_0);
% A_1(isnan(A_1)) = 0;
% 
% B_1 = calcB(a_1_0, a_2_0);
% C_1 = calcC(b_1_0, b_2_0);
% 
% T_1_new = calcNewThreshold(A_1, B_1, C_1, T_1);






















