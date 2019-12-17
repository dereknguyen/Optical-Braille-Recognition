close all;
clear; clc;

I = rgb2gray(imread('pokemon_ruby.png'));
I_bw = im2bw(I, 0.4);
imshow(~I_bw);