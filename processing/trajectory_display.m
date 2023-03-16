%% Trajectoru Display
clear; clc;
cd ('..'); currentfolder = pwd; cd ('processing\');
path = [currentfolder,'\data\'];
% Data Input
load([path,'track\2.5_1.mat']);
for i = 1:12
videoobj(i).video = VideoReader([path,'video(no-github)\2.5_1_',num2str(i),'.mp4']);
end
numframes = 1496;
t = 1000;
C = Track(t).centroid;

%% Trajectroy display by frame
for i = 1:numframes-1
    if C(i,1) > 0 && C(i,2) > 0
        a = floor(C(i,1)/1496); 
        b = floor(C(i,2)/2000);
        loc_video = b*6 + a*1 + 1; 
        L1 = [C(i,1)-1496*a, C(i,2)-2000*b];
        L2 = [C(i+1,1)-1496*a, C(i+1,2)-2000*b];
        frame =read(videoobj(loc_video).video,i);
        figure; imshow(frame); hold on;
        line([L1(1,1),L2(1,1)],[L1(1,2),L2(1,2)],"color","r")
        plot(L1(1,1),L1(1,2),"ob")
        plot(L2(1,1),L2(1,2),"om")
        path_result = [currentfolder,'\result (no-github)\track_',num2str(t),'\',num2str(i),'.jpg'];
        saveas(gcf,path_result);
        close;
    end
end

%% Video Generation
provideo=VideoWriter([currentfolder,'\result (no-github)\track_',num2str(t),'\trajectory.avi']);
endFrame = numframes-1; % The end frames
provideo.FrameRate = 5; % fps = 5
open(provideo); % Open file for writing video data
% imread image from result
for i= 156:532 % endFrame
    frame_path = [currentfolder,'\result (no-github)\track_',num2str(t),'\',num2str(i),'.jpg'];
    frames = imread(frame_path);
    writeVideo(provideo,frames);
end
close(provideo);