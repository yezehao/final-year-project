%%  Read the video information
clear; clc;
videoobj =  ... % input the video to make further process
VideoReader('D:\research\final-year-project\data\2.5_1_1.mp4');
nframes = get (videoobj, "NumFrames"); % Get the number of frames

%% Preprocessing
for i = 1:(nframes-1)
    % Read in the frames
    frame_1 = rgb2gray(read(videoobj,i));
    frame_2 = rgb2gray(read(videoobj,i+1));
    % Use the minimum SE to dilate substracted image
    I = frame_2-frame_1;
    SE = strel('diamond',2); 
    sub = imdilate(I,SE);
    % Display and store the processed images
    imshow(sub);
    path = ['D:\research\final-year-project\data\preprossess\',num2str(i),'.jpg'];
    saveas(gcf,path)
end