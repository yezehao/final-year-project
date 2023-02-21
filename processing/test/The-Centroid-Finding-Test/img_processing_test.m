%% Test for Image Processing %%
clear; clc;
currentfolder = 'C:\Users\30348\OneDrive\桌面\final-year-project';
videoobj =  ... % input the video to make further process
VideoReader([currentfolder,'\data\video(no-github)\2.5_2_4.mp4']);
nframes = get (videoobj, "NumFrames"); % Get the number of frames


i = 150;
% Read in the frames
frame_1 = rgb2gray(read(videoobj,i));
frame_2 = rgb2gray(read(videoobj,i+1));
I = frame_2-frame_1;% get the substration of frames

% image Processing
I_blur = medfilt2(I);           % apply medium filter to the image
I_binary = imbinarize(I_blur,0.095);  % convert grayscale image into binary image, threshold is 25/256 
% SE1 = strel('diamond',1);       % construct SE1 for opening operation
% I_open = imopen(I_binary,SE1);  % use opening operation to remove burrs
I_pro = bwareaopen(I_binary,8); % delete the obj smaller than 8 pixels

SE2 = strel('diamond',3);       % construct SE2 for erosion
I_dilate = imdilate(I_pro,SE2);  % use erosion to shrink objects in an appropriate amount

SE1 = strel('square',3);       % construct SE1 for opening operation
I_open = imopen(I_dilate,SE1);  % use opening operation to remove burrs

% I_pro = bwareaopen(I_binary,5); % delete the obj smaller than 5 pixels
[labelpic,num] = bwlabel (I_open,8); % label the objects

% Region Centroid
prop = regionprops(labelpic,"Centroid"); % get the centroid coordinates
centroid = zeros(length(prop),2);
for n = 1:length(prop)
    centroid(n,1) = prop(n).Centroid(1);
    centroid(n,2) = prop(n).Centroid(2);
end


figure,
imshow(frame_2);
hold on;
for j = 1:length(prop)
plot(prop(j).Centroid(1),prop(j).Centroid(2),'ro');
end

% subplot(2,2,2);imshow(I_open);
% hold on;
% for j = 1:length(prop)
% plot(prop(j).Centroid(1),prop(j).Centroid(2),'ro');
% end
% 
% subplot(2,2,3);imshow(frame_1);
% subplot(2,2,4);imshow(frame_2);


