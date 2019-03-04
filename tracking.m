folder = 'pingpong';
Files = [dir(fullfile(folder,'*.jpeg')); dir(fullfile(folder,'*.jpg'))];

images = cell(length(Files),1);
for k=1:length(Files)
   FileNames=Files(k).name;
   images{k} = imread(FileNames);
   
   [H, r, c] = harris_corner_detector(rgb2gray(images{k}), 99, 0.1, 10, 0);

    cross_size = 10;
    [x,y,z] = size(images{k});
    for i = 1:size(r(:,1))
        left_bound = c(i,1) - cross_size;
        right_bound = c(i,1) + cross_size;
        bottom_bound = r(i,1) - cross_size;
        up_bound = r(i,1) + cross_size;
        if left_bound > 0 && right_bound <= x && bottom_bound > 0 && up_bound <= y
            images{k}(left_bound:right_bound,r(i,1),1) = 255;
            images{k}(c(i,1),bottom_bound:up_bound,1) = 255;
            images{k}(left_bound:right_bound,r(i,1),2) = 0;
            images{k}(c(i,1),bottom_bound:up_bound,2) = 0;
            images{k}(left_bound:right_bound,r(i,1),3) = 0;
            images{k}(c(i,1),bottom_bound:up_bound,3) = 0;
        end
    end
end

%{
frame0 = imread('person_toy/00000001.jpg');

[H, r, c] = harris_corner_detector(rgb2gray(frame0), 99, 0.1, 10, 0);

cross_size = 10;
[x,y,z] = size(frame0);
for i = 1:size(r(:,1))
    left_bound = c(i,1) - cross_size;
    right_bound = c(i,1) + cross_size;
    bottom_bound = r(i,1) - cross_size;
    up_bound = r(i,1) + cross_size;
    if left_bound > 0 && right_bound <= x && bottom_bound > 0 && up_bound <= y
        frame0(left_bound:right_bound,r(i,1),1) = 255;
        frame0(c(i,1),bottom_bound:up_bound,1) = 255;
        frame0(left_bound:right_bound,r(i,1),2) = 0;
        frame0(c(i,1),bottom_bound:up_bound,2) = 0;
        frame0(left_bound:right_bound,r(i,1),3) = 0;
        frame0(c(i,1),bottom_bound:up_bound,3) = 0;
    end
end

%frame0(r(:,1),c(:,1),:) = 255;

imshow(frame0);

%hold on;
%plot(r(:,1),c(:,1), 'r+', 'MarkerSize', 20, 'LineWidth', .5);
%title('Image with cornerpoints');

%}

 %writerObj = VideoWriter('myVideo.avi');