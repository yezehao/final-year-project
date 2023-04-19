%% Test for Image Processing %%
clear; clc;
currentfolder = 'C:\Users\30348\Desktop\final-year-project\';
videoobj = VideoReader([currentfolder,'\data\video(no-github)\5_1_1.mp4']);
nframes = get (videoobj, "NumFrames"); % Get the number of frames

i = 65;
% Read in the frames
frame_1 = rgb2gray(read(videoobj,i));
frame_2 = rgb2gray(read(videoobj,i+1));
I = frame_2-frame_1;% get the substration of frames

% image Processing
I_blur = medfilt2(I);               % apply medium filter to the image
[counts,binLocations] = imhist(I_blur);
for k = 1:256
    counts(k,2) = sum(counts(1:k,1))/299200;
end
I_binary = imbinarize(I_blur,0.095);% convert grayscale image into binary image, threshold is 24/256 
I_pro = bwareaopen(I_binary,4);     % delete the obj smaller than 4 pixels
SE2 = strel('diamond',5);           % construct SE2 for erosion
I_dilate = imdilate(I_pro,SE2);     % use erosion to shrink objects in an appropriate amount
figure,
subplot(1,5,1);imshow(I_dilate);
for j = 2:5
    subplot(1,5,j);
    SE = strel('square',j);
    I_o = imopen(I_dilate,SE);
    imshow(I_o)
    hold on
end
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

figure,
subplot(1,4,1);imshow(frame_1); hold on;
for j = 1:length(prop)
    plot(prop(j).Centroid(1),prop(j).Centroid(2),'ro');end
subplot(1,4,2);imshow(I_blur); hold on;
for j = 1:length(prop)
    plot(prop(j).Centroid(1),prop(j).Centroid(2),'ro');end
subplot(1,4,3);imshow(I_binary); hold on;
for j = 1:length(prop)
    plot(prop(j).Centroid(1),prop(j).Centroid(2),'ro');end
subplot(1,4,4);imshow(I_open); hold on;
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

%% Error Calculation
actual = [7,229; 58,792; 116,100; 119,162;
          119,1904; 119,1904; 244,120; 526,30;
          778,1608; 794,1647; 810,1686; 1018.5,1284; % The two vehicles are getting together 1024,1293 1013,1275
          1024,1206; 1042,1186; 1071,1078; 1080,1005;
          1101,1931; 1099,1904; 1111,1738; 1125,921;
          1161,1626; 1155,177; 1155,1360; 1169,1114;
          1188,719; 1206,1317.5; 1204,1629; 1229,593;
          1245,1022; 1238,522; 1244,1633; 1246,1321;
          1285,1323; 1303,1026; 1295,1639; 1328,308;
          1362,1030; 1388,154; 1422,1336; 1425,1034];
error = centroid - actual;
result(:,1:2) = centroid;
result(:,3:4) = actual;
result(:,5:6) = error;

error = roundn(error,-3);
mean_ = mean(error(:,1:2));
std_ = std(error(:,1:2));

error_abs = abs(error);
mean_abs = mean(error_abs(:,1:2));
std_abs = std(error_abs(:,1:2));

R = [mean_; std_;
     mean_abs; std_abs];




