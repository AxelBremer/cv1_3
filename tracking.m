function [] = tracking(folder)

Files = [dir(fullfile(folder,'*.jpeg')); dir(fullfile(folder,'*.jpg'))];

images = cell(length(Files),1);
FileNames = cell(length(Files),1);
for k=1:length(Files)
   FileNames{k} = strcat(folder, '/', Files(k).name);
   images{k} = imread(FileNames{k});
end

[~, r, c] = harris_corner_detector(im2double(rgb2gray(images{1})), 25, 0.1, 4, 0);

for k=1:length(Files)
    [size_x,size_y,~] = size(images{k});
    if k > 1
        [vy,vx,~,~,~,~] = lucas_kanade(FileNames{k-1}, FileNames{k});
        for i = 1:size(r(:,1))
            index_r = ceil(r(i,1)/15);
            index_c = ceil(c(i,1)/15);
            if index_r > size(vx,2)
                index_r = size(vx,2);
            end
            if index_c > size(vx,1)
                index_c = size(vx,1);
            end
            r(i,1) = r(i,1) + round(1.7*vy(index_c,index_r));
            c(i,1) = c(i,1) + round(1.7*vx(index_c,index_r));
            if r(i,1) < 1
                r(i,1) = 1;
            end
            if r(i,1) > size(images{k},2)
                r(i,1) = size(images{k},2);
            end
            if c(i,1) < 1
                c(i,1) = 1;
            end
            if c(i,1) > size(images{k},1)
                c(i,1) = size(images{k},1);
            end
            arrow_size = size_x/10;
            head_arrow_size = arrow_size/5;
            for j = 0:arrow_size
                x = c(i,1) + j*vx(index_c,index_r);
                y = r(i,1) + j*vy(index_c,index_r);
                images{k} = color_red(images{k},x,y,size_x,size_y);
            end
            vx_arrow = vx(index_c,index_r)*cos(3*pi/4) - vy(index_c,index_r)*sin(3*pi/4);
            vy_arrow = vx(index_c,index_r)*sin(3*pi/4) + vy(index_c,index_r)*cos(3*pi/4);
            for j = 0:head_arrow_size
                x = c(i,1) + arrow_size*vx(index_c,index_r) + j*vx_arrow;
                y = r(i,1) + arrow_size*vy(index_c,index_r) + j*vy_arrow;
                images{k} = color_red(images{k},x,y,size_x,size_y);
            end
            vx_arrow = vx(index_c,index_r)*cos(-3*pi/4) - vy(index_c,index_r)*sin(-3*pi/4);
            vy_arrow = vx(index_c,index_r)*sin(-3*pi/4) + vy(index_c,index_r)*cos(-3*pi/4);
            for j = 0:head_arrow_size
                x = c(i,1) + arrow_size*vx(index_c,index_r) + j*vx_arrow;
                y = r(i,1) + arrow_size*vy(index_c,index_r) + j*vy_arrow;
                images{k} = color_red(images{k},x,y,size_x,size_y);
            end
        end
    else
        for i = 1:size(r(:,1))
            if c(i,1) > 0 && c(i,1) <= size_x && r(i,1) > 0 && r(i,1) <= size_y
                images{k}(c(i,1),r(i,1),1) = 255;
                images{k}(c(i,1),r(i,1),2) = 0;
                images{k}(c(i,1),r(i,1),3) = 0;
            end
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

function [image] = color_red(image,x,y,size_x,size_y)
    if x >= 1 && x <= size_x && y >= 1 && y <= size_y
        image(floor(x),floor(y),1) = 255;
        image(floor(x),floor(y),2) = 0;
        image(floor(x),floor(y),3) = 0;
        image(ceil(x),ceil(y),1) = 255;
        image(ceil(x),ceil(y),2) = 0;
        image(ceil(x),ceil(y),3) = 0;
    end
end