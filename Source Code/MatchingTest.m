close all;
clear; clc;

% GENERATE ALPHABET TEMPLATE
%==========================================================================
alph_dir = dir('Alphabet');
template = getAlphabetTemplate(alph_dir, '.jpg');
%==========================================================================


% DECODE CROPPED AREA OF INTEREST
%==========================================================================
img_dir = dir('Cropped');
result = decode(template, img_dir, '.jpg');
%==========================================================================
