function result = lucas_kanade()
img1 = imread('sphere1.ppm');
img2 = imread('sphere2.ppm');

image1 = convert2grayscale(img1);
image2 = convert2grayscale(img1);

regions1 = img2regions(image1);
regions2 = img2regions(image2);

[x_blocks, y_blocks] = size(regions1);
v = zeros(x_blocks, y_blocks, 2);
for i = 1:x_blocks
   for j = 1:y_blocks
       [A_T, b] = get_optical_flow(regions1(i, j), regions2(i, j));
       v = A_T * b;
   end
end

end

function image = convert2grayscale(img)
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    image = im2double(img);
end

function regions = img2regions(image)
region_size = 15;

x_regions = floor(size(image, 1)/ region_size);
y_regions = floor(size(image, 2)/ region_size);

x_size = x_regions * region_size;
y_size = y_regions * region_size;

region_size_vec_x = region_size * ones(1, x_regions);
region_size_vec_y = region_size * ones(1, y_regions);

regions = mat2cell(image(1:x_size, 1:y_size), region_size_vec_y, region_size_vec_x);
end

function [A_T, b] = get_optical_flow(region1, region2)
[Ix, Iy] = gradient(region1);
A = [Ix(:), Iy(:)];
It = region2 - region1;
b = -It(:);
A_T = pinv(A);
end