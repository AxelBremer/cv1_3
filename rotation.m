im = im2double(rgb2gray(imread('person_toy/00000001.jpg')));
im45 = imrotate(im, 45);
im90 = imrotate(im, 90);

subplot(131)
[H, r, c] = harris_corner_detector(im, 15, 0.02, 4, 0);
imshow(im);
hold on;
plot(r(:,1),c(:,1), 'r+', 'MarkerSize', 10, 'LineWidth', .2);
subplot(132)
[H, r, c] = harris_corner_detector(im45, 15, 0.02, 4, 0);
imshow(im45);
hold on;
plot(r(:,1),c(:,1), 'r+', 'MarkerSize', 10, 'LineWidth', .2);
subplot(133)
[H, r, c] = harris_corner_detector(im90, 15, 0.02, 4, 0);
imshow(im90);
hold on;
plot(r(:,1),c(:,1), 'r+', 'MarkerSize', 10, 'LineWidth', .2);