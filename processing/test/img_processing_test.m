%% Test for Image Processing %%
clear; clc;
videoobj =  ... % input the video to make further process
VideoReader('C:\Users\30348\OneDrive\桌面\final-year-project\data\video\2.5_1_1.mp4');
nframes = get (videoobj, "NumFrames"); % Get the number of frames


i = 1000;
% Read in the frames
frame_1 = rgb2gray(read(videoobj,i));
frame_2 = rgb2gray(read(videoobj,i+1));
I = frame_2-frame_1;% get the substration of frames

% image Processing
I_blur = medfilt2(I);           % apply medium filter to the image
I_binary = imbinarize(I_blur,0.03);  % convert grayscale image into binary image
SE1 = strel('diamond',1);       % construct SE1 for opening operation
I_open = imopen(I_binary,SE1);  % use opening operation to remove burrs
SE2 = strel('diamond',1);       % construct SE2 for erosion
I_erode = imerode(I_open,SE2);  % use erosion to shrink objects in an appropriate amount
I_pro = bwareaopen(I_binary,5); % delete the obj smaller than 5 pixels
[labelpic,num] = bwlabel (I_pro,4); % label the objects
figure,
subplot(1,4,1);imshow(I);
subplot(1,4,2);imshow(I_binary);
subplot(1,4,3);imshow(I_open);
subplot(1,4,4);imshow(I_erode);



