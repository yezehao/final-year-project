%% Test for Image Processing %%
clear; clc;
currentfolder = 'C:\Users\30348\Desktop\final-year-project\';
videoobj = VideoReader([currentfolder,'\data\video(no-github)\2.5_2_4.mp4']);
nframes = get (videoobj, "NumFrames"); % Get the number of frames

i = 100;
% Read in the frames
frame_1 = rgb2gray(read(videoobj,i));
frame_2 = rgb2gray(read(videoobj,i+1));
I = frame_2-frame_1;% get the substration of frames

% image Processing
I_blur = medfilt2(I);               % apply medium filter to the image
I_binary = imbinarize(I_blur,0.095);% convert grayscale image into binary image, threshold is 25/256 
I_pro = bwareaopen(I_binary,5);     % delete the obj smaller than 8 pixels
SE2 = strel('diamond',5);           % construct SE2 for erosion
I_dilate = imdilate(I_pro,SE2);     % use erosion to shrink objects in an appropriate amount
SE1 = strel('square',5);            % construct SE1 for opening operation
I_open = imopen(I_dilate,SE1);      % use opening operation to remove burrs
[labelpic,num] = bwlabel (I_open,8);% label the objects

% Region Centroid
prop = regionprops(labelpic,"Centroid"); % get the centroid coordinates
for n = 1:length(prop)
    centroid(n,1) = prop(n).Centroid(1);
    centroid(n,2) = prop(n).Centroid(2);
end

figure,
imshow(frame_1);
hold on;
for j = 1:length(prop)
    plot(prop(j).Centroid(1),prop(j).Centroid(2),'ro');end

% figure,
% subplot(2,2,1);imshow(I);hold on;
% for j = 1:length(prop)
%     plot(prop(j).Centroid(1),prop(j).Centroid(2),'ro');end
% subplot(2,2,2);imshow(I_blur);hold on;
% for j = 1:length(prop)
%     plot(prop(j).Centroid(1),prop(j).Centroid(2),'ro');end
% subplot(2,2,3);imshow(I_dilate);hold on;
% for j = 1:length(prop)
%     plot(prop(j).Centroid(1),prop(j).Centroid(2),'ro');end
% subplot(2,2,4);imshow(I_open);hold on;
% for j = 1:length(prop)
%     plot(prop(j).Centroid(1),prop(j).Centroid(2),'ro');end