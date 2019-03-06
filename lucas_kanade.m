function [vx, vy, axes] = lucas_kanade(im_path1, im_path2)
region_size = 15;

img1 = imread(im_path1);
img2 = imread(im_path2);

image1 = convert2grayscale(img1);
image2 = convert2grayscale(img2);

regions1 = img2regions(image1, region_size);
regions2 = img2regions(image2, region_size);

[x_blocks, y_blocks] = size(regions1);

vx = zeros(x_blocks, y_blocks);
vy = zeros(x_blocks, y_blocks);

axes = region_size * (1:y_blocks) - floor(region_size/2);
for i = 1:x_blocks
   for j = 1:y_blocks
       [A, b] = get_optical_flow(regions1(i, j), regions2(i, j));
       v = inv(A'*A)*A'*b;
       vx(i,j) = v(1);
       vy(i,j) = v(2);
   end
end

end

function image = convert2grayscale(img)
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    image = im2double(img);
end

function regions = img2regions(image, region_size)
x_regions = floor(size(image, 1)/ region_size);
y_regions = floor(size(image, 2)/ region_size);

x_size = x_regions * region_size;
y_size = y_regions * region_size;

region_size_vec_x = region_size * ones(1, x_regions);
region_size_vec_y = region_size * ones(1, y_regions);

regions = mat2cell(image(1:x_size, 1:y_size), region_size_vec_y, region_size_vec_x);
end

function [A, b] = get_optical_flow(region1, region2)
[Ix, Iy] = gradient(region1{1});
A = [Ix(:), Iy(:)];
It = region2{1} - region1{1};
b = -It(:);
end