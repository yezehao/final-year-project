%% Detection with 1 Specific Vehicle Display
clear; clc;
cd ('..'); currentfolder = pwd; cd ('processing\');
path = [currentfolder,'\data\'];
% Data Input
load([path,'track\2.5_1.mat']);

numframes = 1496;
frame_l = 2000; % The length of frame
frame_w = 1496; % The width of frame

for i = 1:length(Track)
    Track(i).centroid(1496,:) = [0,0];
end

for t = 1:length(Track)
    C = Track(t).centroid;
    firstrun = 0;
    % Tracking display by frame
    for i = 1:numframes-2
        if C(i,1) ~= 0 && C(i+1,1) ~= 0
            a(1,1) = floor(C(i,1)/1496); a(2,1) = floor(C(i,2)/2000);
            a(3,1) = 1; loc_video1 = [1,6,1]*a;
            b(1,1) = floor(C(i+1,1)/1496); b(2,1) = floor(C(i+1,2)/2000);
            b(3,1) = 1; loc_video2 = [1,6,1]*b;
            if loc_video1 ~= loc_video2
                firstrun = firstrun + 1;
                traj(t).frame(firstrun,:) = [i, loc_video1];
            end
        elseif C(i,1) == 0 && C(i+1,1) == 0
            if i == 1494
                firstrun = firstrun+1;
                traj(t).frame(firstrun,:) = [1495,0];
            end
        elseif C(i,1) == 0 && C(i+1,1) ~= 0
            loc_video = 0;
            firstrun = firstrun + 1;
            traj(t).frame(firstrun,:) = [i,loc_video];
        else % C(i,1) ~= 0 && C(i+1,1) == 0
            firstrun = firstrun + 1;
            a(1,1) = floor(C(i,1)/1496); a(2,1) = floor(C(i,2)/2000);
            a(3,1) = 1; loc_video1 = [1,6,1]*a;
            traj(t).frame(firstrun,:) = [i, loc_video1];
        end
    end
end

% clear variables
clearvars a b C firstrun  i loc_video loc_video1 loc_video2 t 

for i = 1:length(traj)
    a = traj(i).frame;
    for j = 1:length(a(:,1))-2
        traj(i).L(j,1) = a(j+1,1)-a(j,1);
    end
end

for i = 1:length(traj)
    if isempty(traj(i).L) == 0
        MAX(i,1) = max(traj(i).L);
    else
        MAX(i,1) = 0;
    end
end

[max1,max2] = find(MAX==max(MAX));
frame_t = traj(max1).frame; 
T_sp = Track(max1).centroid;
frame1 = frame_t(1,1)+1;
frame2 = frame_t(2,1);
loc_video = frame_t(2,2);

videoobj = VideoReader([path,'video(no-github)\2.5_1_',num2str(loc_video),'.mp4']);
load([currentfolder,'\data\centroid\2.5_1_',num2str(loc_video),]);

for i = frame1:frame2
    frame =read(videoobj,i);
    C = structure(i).centroid;
    figure, 
    imshow(frame); % Plot the background
    hold on
    % Plot all the detections
    for j = 1:length(C(:,1))
        plot(C(j,1),C(j,2),"or")
    end
    % Plot the Track of specific car
    for k = frame1:frame2-1 
        sub = [frame_w * 0, frame_l * 0]; % need to be modify if the video changed
        L = [T_sp(k,1), T_sp(k,2); T_sp(k+1,1), T_sp(k+1,2)] - [sub;sub];
        line([L(1),L(2)],[L(3),L(4)],"color","blue")
    end
    % Plot the location of the specific car
    sub = [frame_w * 0, frame_l * 0]; % need to be modify if the video changed
    loca = [T_sp(i,1), T_sp(i,2)] - sub;
    plot(loca(1,1),loca(1,2),"*m")

    path_result = [currentfolder,'\result (no-github)\measurement with 1 car\',num2str(i),'.jpg'];
    saveas(gcf,path_result);
    close;
end

% Video Generation
provideo=VideoWriter([currentfolder,'\result (no-github)\measurement with 1 car.avi']);
endFrame = numframes-1; % The end frames
provideo.FrameRate = 5; % fps = 5
open(provideo); % Open file for writing video data
% imread image from result
for i= frame1:frame2 % endFrame
    frame_path = [currentfolder,'\result (no-github)\measurement with 1 car\',num2str(i),'.jpg'];
    frames = imread(frame_path);
    writeVideo(provideo,frames);
end
close(provideo);