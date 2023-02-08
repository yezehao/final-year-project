%%  Read the video information
clear; clc;
videoobj =  ... % input the video to make further process
VideoReader('C:\Users\30348\Documents\final-year-project\data\video\2.5_1_1.mp4');
nframes = get (videoobj, "NumFrames"); % Get the number of frames

%% Image Processing
for i = 1:(nframes-1)
    % Read in the frames
    frame_1 = rgb2gray(read(videoobj,i));
    frame_2 = rgb2gray(read(videoobj,i+1));
    I = frame_2-frame_1;% get the substration of frames
    
    % image Processing
    SE1 = strel('diamond',4); % construct SE1 for dilation
    I_dilation = imdilate(I,SE1); % use dilation to expand the object
    I_pre = imbinarize(I_dilation,0.05); % convert grayscale image into binary image
    SE2 = strel('diamond',2); % construct SE2 for erosion
    I_binary = imerode(I_pre,SE2);
    I_pro = bwareaopen(I_binary,30); % delete the obj smaller than 30 pixels
    [labelpic,num] = bwlabel (I_pro,4); % label the objects
    
    % Region Centroid
    prop = regionprops(labelpic,"Centroid"); % get the centroid coordinates
    m = size(prop);
    centroid = zeros(m(1),2);
    for n = 1:m(1)
        centroid(n,1) = prop(n).Centroid(1);
        centroid(n,2) = prop(n).Centroid(2);
    end
    structure(i).centroid = centroid; % store the coordinates in the structure
    % This is added for knowing the progress of image processing 
    if mod(i,20) == 0
        disp(i);
    end
end

clc;

%% Save the structure into data file
save('C:\Users\30348\Documents\final-year-project\data\centroid\2.5_1_1.mat','structure')
%% Save the structure into processing file for further process
save('centroid\2.5_1_1.mat','structure')
