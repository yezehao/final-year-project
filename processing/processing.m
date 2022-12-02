%%  Read the video information
clear; clc;
videoobj =  ... % input the video to make further process
VideoReader('D:\research\final-year-project\data\video\2.5_1_1.mp4');
nframes = get (videoobj, "NumFrames"); % Get the number of frames

%% Preprocessing
for i = 1:(nframes-1)

    % Read in the frames
    frame_1 = rgb2gray(read(videoobj,i));
    frame_2 = rgb2gray(read(videoobj,i+1));
    I = frame_2-frame_1;% get the substration of frames

    % image Processing
    SE = strel('diamond',2); % construct SE for dilation
    I_dilation = imdilate(I,SE); % use dilation to expand the object
    I_pre = imbinarize(I_dilation,0.12); % convert grayscale image into binary image
    I_binary = imdilate(I_pre,SE);
    I_pro = bwareaopen(I_binary,5); % delete the obj smaller than 5 pixels
    [labelpic,num] = bwlabel (I_pro,8); % label the objects
    
    % Region Centroid
    prop = regionprops(labelpic,"Centroid"); % get the centroid coordinates
    structure(i).centroid = prop; % store the coordinates in the structure

    % Display and store the processed images
    % imshow(sub);
    % path = ['D:\research\final-year-project\data\preprossess\',num2str(i),'.jpg'];
    % saveas(gcf,path)
end

%% Save the structure into preprocessing file
save('D:\research\final-year-project\data\process_result\2.5_1_1.mat','structure')
