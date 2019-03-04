function [H, r, c] = harris_corner_detector(image, kernel_size, threshold, sigma, print)
%HARRIS_CORNER_DETECTOR
G2 = gauss2D(0.5, 3);
G = gauss1D(0.5, 3);
Gx = [-1 0 1 ; -2 0 2 ; -1 0 1];
Gy = [-1 -2 -1 ; 0 0 0 ; 1 2 1];
Ix = conv2(image, Gx, 'same');
Iy = conv2(image, Gy, 'same');

A = conv2(Ix.^2, G, 'same');
B = conv2(Ix.*Iy, G2, 'same');
C = conv2(Iy.^2, G, 'same');

H = (A.*C - B.^2) - 0.04*(A+C).*(A+C);
% H = (A.*C - B.^2)./(A+C).*(A+C);
r = [];
c = [];

if mod(kernel_size,2) == 0
    disp('Kernel size should be odd')
    return
end
n = floor(kernel_size/2);

for i = 1:size(H,1)
    for j = 1:size(H,2)
        y1 = i-n;
        y2 = i+n;
        x1 = j-n;
        x2 = j+n;
        if y1 < 1
            y1 = 1;
            y2 = kernel_size;
        end
        if y2 > size(H,1)
            y1 = size(H,1)-kernel_size;
            y2 = size(H,1);
        end
        if x1 < 1
            x1 = 1;
            x2 = kernel_size;
        end
        if x2 > size(H,2)
            x1 = size(H,2)-kernel_size;
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

