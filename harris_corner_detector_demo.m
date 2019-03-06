im = im2double(rgb2gray(imread('person_toy/00000001.jpg')));
harris_corner_detector(im, 25, 0.085, 4, 1);