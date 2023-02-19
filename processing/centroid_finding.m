%%  Read the video information
clear; clc;
% get the path of current folder
cd ('..');
currentfolder = pwd;
cd ('processing\');
path = [currentfolder,'\data\'];
% read in the information about video
for j = 1:12
    videoobj =  ... 
    VideoReader([path,'video(no-github)\2.5_2_',num2str(j),'.mp4']);
    nframes = get (videoobj, "NumFrames"); % Get the number of frames
    
    %% Image Processing Version 2
    for i = 1:(nframes-1)
        % Image Processing
        [centroid] = ImageProcessing(videoobj,i);    
        structure(i).centroid = centroid; % store the coordinates in the structure
        % This is added for knowing the progress of image processing 
        if mod(i,20) == 0
            disp(i);
        end
    end
    
    %% Save the structure into data file
    filename = ['2.5_2_',num2str(j),'.mat'];
    save([path,'\centroid_v2\',filename],'structure')
    % clear variables
    clearvars structure videoobj
end