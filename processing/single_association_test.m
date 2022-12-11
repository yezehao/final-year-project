%% This programme is used for testing %%
clear; clc;

% for i = 1:numframes-1
%     for j = 1:200
%     z(1) = coordinate(1,i);
%     z(2) = coordinate(2,i);
%     y = kalmanfilter(z);
%     % frame = rgb2gray(read(videoobj,i));
%     % figure;
%     % imshow(frame)
%     % hold on;
%     % plot(z(1), z(2), 'ro');
%     % plot(y(1), y(2), 'bx');
%     % path = ['C:\Users\30348\Documents\final-year-project\result\kalmanfilter\' num2str(i) '.jpg'];
%     % saveas(gcf,path)
%     % close;
%     end
% end

load('C:\Users\30348\Documents\final-year-project\data\centroid\2.5_1_1.mat');
load('C:\Users\30348\Documents\final-year-project\data\association\2.5_1_1.mat');
load('C:\Users\30348\Documents\final-year-project\data\state\2.5_1_1.mat');


dt=0.2;
% Initialize state transition matrix
A=[ 1 0 dt 0;...     % [x ]            
    0 1 0 dt;...     % [y ]
    0 0 1 0 ;...     % [Vx]
    0 0 0 1];...     % [Vy]
% Initialize measurement matrix
H = [ 1 0 0 0 ;...
      0 1 0 0];   



%% Kalman Filter
for i = 54:58
        predict_state = A*state(1:4,i);
        predict_coord = H*predict_state;
        measured_coord = H*state(1:4,i+1);
        S_ = A*S*F_t;
        K = S*H_t*((H*S*H_t)^(-1));
        actual_state(:,i) = predict_state + K*(measured_coord - predict_coord);
        S = (eye(4)-K*H)*S_;
end
% clear the useless variables
% clearvars predict_state predict_coord measured_coord
% clearvars F F_t H H_t S_