%% This programme is used for testing %%
clear; clc;
load('C:\Users\30348\Documents\final-year-project\data\authorization\2.5_1_1.mat');
videoobj = VideoReader('C:\Users\30348\Documents\final-year-project\data\video\2.5_1_1.mp4');
numframes = videoobj.NumFrames; 

for i = 1:numframes-1
    for j = 1:200
    z(1) = coordinate(1,i);
    z(2) = coordinate(2,i);
    y = kalmanfilter(z);
    % frame = rgb2gray(read(videoobj,i));
    % figure;
    % imshow(frame)
    % hold on;
    % plot(z(1), z(2), 'ro');
    % plot(y(1), y(2), 'bx');
    % path = ['C:\Users\30348\Documents\final-year-project\result\kalmanfilter\' num2str(i) '.jpg'];
    % saveas(gcf,path)
    % close;
    end
end

% % write blank video
% provideo=VideoWriter('C:\Users\30348\Documents\final-year-project\result\kalmanfilter');
% endFrame = 200; % The end frames
% provideo.FrameRate = 5; % fps = 5
% open(provideo); % Open file for writing video data
% % imread image from result
% for i= 1:endFrame
%     frames = imread(['C:\Users\30348\Documents\final-year-project\result\kalmanfilter\',num2str(i),'.jpg']);
%     writeVideo(provideo,frames);
% end
% close(provideo);

% %% Kalman Filter
% for i = 1:numframes-3
%     if state(1,i) ~= 0 && state(3,i) ~= 0
%         predict_state = A*state(:,i);
%         predict_coord = H*predict_state;
%         measured_coord = H*state(:,i+1);
%         S_ = A*S*F_t;
%         K = S*H_t*((H*S*H_t)^(-1));
%         actual_state(:,i) = predict_state + K*(measured_coord - predict_coord);
%         S = (eye(4)-K*H)*S_;
%     end
% end
% clear the useless variables
% clearvars predict_state predict_coord measured_coord
% clearvars F F_t H H_t S_