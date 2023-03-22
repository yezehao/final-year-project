%% Detection Display
clear; clc;
cd ('..'); currentfolder = pwd; cd ('processing\');
path = [currentfolder,'\data\'];
for i = 2:12
    % Data Input
    load([path,'centroid\2.5_1_',num2str(i),'.mat']);
    videoobj = VideoReader([path,'video(no-github)\2.5_1_',num2str(i),'.mp4']);
    numframes = 1496;
    for j = 1:numframes-1
        centroid = structure(j).centroid;
        frame =read(videoobj,j);
        figure,
        imshow(frame);
        hold on
        if isempty(centroid) == 0
            for k = 1:length(centroid(:,1))
                plot(centroid(k,1),centroid(k,2),"or")
            end
        end
        path_result = [currentfolder,'\result (no-github)\measurement\2.5_1_',num2str(i),'_',num2str(j),'.jpg'];
        saveas(gcf,path_result);
        close;
    end
end

% Video Generation
for j = 2:12
provideo=VideoWriter([currentfolder,'\result (no-github)\measurement_2.5_1_',num2str(j),'.avi']);
endFrame = numframes-1; % The end frames
provideo.FrameRate = 5; % fps = 5
open(provideo); % Open file for writing video data
% imread image from result
for i= 1:endFrame % endFrame
    frame_path = [currentfolder,'\result (no-github)\measurement\2.5_1_',num2str(j),'_',num2str(i),'.jpg'];
    frames = imread(frame_path);
    writeVideo(provideo,frames);
end
close(provideo);
end