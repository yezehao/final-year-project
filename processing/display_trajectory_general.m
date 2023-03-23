%% Trajectory Display In General
clear; clc;
cd ('..'); currentfolder = pwd; cd ('processing\');
path = [currentfolder,'\data\'];
% Data Input
load([path,'track\2.5_2.mat']);

for i = 1:12
videoobj(i).video = VideoReader([path,'video(no-github)\2.5_2_',num2str(i),'.mp4']);
end
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
            % Do nothing
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

% Trajectroy about video 2.5_1_?
a_totol = [0,0,1;1,0,1;
           2,0,1;3,0,1;
           4,0,1;5,0,1;
           0,1,1;1,1,1;
           2,1,1;3,1,1;
           4,1,1;5,1,1;];
for l = 1:12
frame =read(videoobj(l).video,200);
figure; imshow(frame); hold on;
a = a_totol(l,:); % represent video 2.5_1_?
sub = [frame_w * a(1), frame_l * a(2)];

for t = 1:length(traj)
    T = traj(t).frame;
        [t1,t2] = find(T(:,2) == l);
        if isempty(t1) == 0 % select the track matched
            f_s = T(t1-1,1)+1; % The start frame
            f_e = T(t1,1); % The end frame
            C = Track(t).centroid;
            for n = 1:length(f_s)
                for k = f_s(n):f_e(n)-1
                    L = [C(k,:); C(k+1,:)] - [sub; sub];
                    line([L(1),L(2)],[L(3),L(4)],"color","m");
                end
            end
    end
end
path_result = [currentfolder,'\result (no-github)\video 2.5_2_',num2str(l),' general.jpg'];
saveas(gcf,path_result); close;
end