function [H, r, c] = harris_corner_detector(image, neighbourhood_size, threshold, sigma, print)
%HARRIS_CORNER_DETECTOR
% Image should be im2doubled and rgb2grayed
% Values we used are 
% neighbourhood_size = 25, threshold = 0.015 - 0.9 depending
% sigma = 4

G2 = gauss2D(sigma, 5);
Gx = [-1 0 1 ; -2 0 2 ; -1 0 1];
Gy = [-1 -2 -1 ; 0 0 0 ; 1 2 1];
Ix = conv2(image, Gx, 'same');
Iy = conv2(image, Gy, 'same');

A = conv2(Ix.^2, G2, 'same');
B = conv2(Ix.*Iy, G2, 'same');
C = conv2(Iy.^2, G2, 'same');

H = (A.*C - B.^2) - 0.04*(A+C).*(A+C);

r = [];
c = [];

if mod(neighbourhood_size,2) == 0
    disp('Kernel size should be odd')
    return
end
n = floor(neighbourhood_size/2);

for i = 1:size(H,1)
    for j = 1:size(H,2)
        y1 = i-n;
        y2 = i+n;
        x1 = j-n;
        x2 = j+n;
        if y1 < 1
            y1 = 1;
            y2 = neighbourhood_size;
        end
        if y2 > size(H,1)
            y1 = size(H,1)-neighbourhood_size;
            y2 = size(H,1);
        end
        if x1 < 1
            x1 = 1;
            x2 = neighbourhood_size;
        end
        if x2 > size(H,2)
            x1 = size(H,2)-neighbourhood_size;
            x2 = size(H,2);
        end
        temp = H(y1:y2,x1:x2);
        if H(i,j) == max(max(temp)) && H(i,j) > threshold
            r(size(r,1)+1,:) = j;
            c(size(c,1)+1,:) = i;
        end
    end
end

if print == 1
    subplot(131)
    imshow(Ix);
    title('Ix');
    subplot(132)
    imshow(Iy);
    title('Iy');
    subplot(133)
    imshow(image);
    hold on;
    plot(r(:,1),c(:,1), 'r+', 'MarkerSize', 10, 'LineWidth', .2);
    title('Image with cornerpoints');
end
end

