%% This programme is used to make the video for presentation
clear; clc;
load('C:\Users\30348\Documents\final-year-project\data\association\2.5_1_1.mat');
videoobj = VideoReader('C:\Users\30348\Documents\final-year-project\data\video\2.5_1_1.mp4');
numframes = videoobj.NumFrames;

for i = 1:numframes-3
    frame = rgb2gray(read(videoobj,i));
    figure;
    imshow(frame)
    hold on;
    for j = 1:68
        z(1) = coordinate(3*j-2,i);
        z(2) = coordinate(3*j-1,i);
        plot(z(1), z(2), 'ro');
    end
    path = ['C:\Users\30348\Documents\final-year-project\result\vehicle(no-github)\' num2str(i) '.jpg'];
    saveas(gcf,path)
    close;
end
% write blank video
provideo=VideoWriter('C:\Users\30348\Documents\final-year-project\result\vehicletracking(no-github)');
endFrame = numframes-3; % The end frames
provideo.FrameRate = 5; % fps = 5
open(provideo); % Open file for writing video data
% imread image from result
for i= 1:endFrame
    frames = imread(['C:\Users\30348\Documents\final-year-project\result\vehicle(no-github)\',num2str(i),'.jpg']);
    writeVideo(provideo,frames);
end
close(provideo);

