%% This programme is used to make the video for presentation
clear; clc;
load('C:\Users\30348\Documents\final-year-project\data\authorization\2.5_1_1.mat');
videoobj = VideoReader('C:\Users\30348\Documents\final-year-project\data\video\2.5_1_1.mp4');

for i = 1:200
    frame = rgb2gray(read(videoobj,i));
    figure;
    imshow(frame)
    hold on;
    z(1) = coordinate(1,i);
    z(2) = coordinate(2,i);
    plot(z(1), z(2), 'ro');
    path = ['C:\Users\30348\Documents\final-year-project\result\single-vehicle\' num2str(i) '.jpg'];
    saveas(gcf,path)
    close;
end
% write blank video
provideo=VideoWriter('C:\Users\30348\Documents\final-year-project\result\single-vehicle-tracking');
endFrame = 200; % The end frames
provideo.FrameRate = 5; % fps = 5
open(provideo); % Open file for writing video data
% imread image from result
for i= 1:endFrame
    frames = imread(['C:\Users\30348\Documents\final-year-project\result\single-vehicle\',num2str(i),'.jpg']);
    writeVideo(provideo,frames);
end
close(provideo);

