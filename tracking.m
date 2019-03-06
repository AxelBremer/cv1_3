function [] = tracking(folder)

Files = [dir(fullfile(folder,'*.jpeg')); dir(fullfile(folder,'*.jpg'))];

images = cell(length(Files),1);
FileNames = cell(length(Files),1);
for k=1:length(Files)
   FileNames{k} = strcat(folder, '/', Files(k).name);
   images{k} = imread(FileNames{k});
end

[~, r, c] = harris_corner_detector(rgb2gray(images{1}), 99, 0.1, 10, 0);

for k=1:length(Files)
    if k > 1
        [vx,vy,~,~,~,~] = lucas_kanade(FileNames{k-1}, FileNames{k});
        size(vy)
        for i = 1:size(r(:,1))
            index_r = ceil(r(i,1)/15);
            index_c = ceil(c(i,1)/15);
            if index_r > size(vx(1,:))
                index_r = size(vx(1,:));
            end
            if index_c > size(vx(:,1))
                index_c = size(vx(:,1));
            end
            vy(index_c,index_r)
            r(i,1) = r(i,1) + vy(index_c,index_r);
            c(i,1) = c(i,1) + vx(index_c,index_r);
            if r(i,1) < 1
                r(i,1) = 1;
            end
            if r(i,1) > size(images{k}(1,:,1))
                r(i,1) = size(images{k}(1,:,1));
            end
            if c(i,1) < 1
                c(i,1) = 1;
            end
            if c(i,1) > size(images{k}(:,1,1))
                c(i,1) = size(images{k}(:,1,1));
            end
        end
    end
    
    cross_size = 10;
    [x,y,~] = size(images{k});
    for i = 1:size(r(:,1))
        left_bound = c(i,1) - cross_size;
        right_bound = c(i,1) + cross_size;
        bottom_bound = r(i,1) - cross_size;
        up_bound = r(i,1) + cross_size;
        %r(i,1)
        %c(i,1)
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

 % create the video writer with 1 fps
 writerObj = VideoWriter(strcat(folder, '.avi'));
 writerObj.FrameRate = 5;
 % set the seconds per image
 secsPerImage = 1;
 % open the video writer
 open(writerObj);
 % write the frames to the video
 for u=1:length(images)
     % convert the image to a frame
     frame = im2frame(images{u});
     for v=1:secsPerImage 
         writeVideo(writerObj, frame);
     end
 end
 % close the writer object
 close(writerObj);
 
end