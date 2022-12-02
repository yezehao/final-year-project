%% The programme about Kalman Filter %%
clear; clc;

load('D:\research\final-year-project\data\authorization\2.5_1_1.mat');
numframes = 1495; % the number of frames is 1495
delta_t = 0.2; % the frame rate is 5 frames/s, in hence the Δt = 0.2s

%% get the series of state about the vehicle
for i = 1:numframes-3   
    % read in the measurand
    prev = coordinate(i,:); 
    temp = coordinate(i+1,:);
    next = coordinate(i+2,:);
    % store the state of vehicles
    state(i,1) = temp(1); % coordinate x
    state(i,2) = (next(1)-prev(1))/delta_t; % velocity x
    state(i,3) = temp(2); % coordinate y
    state(i,4) = (next(2)-prev(2))/delta_t; % velocity y
end

% Calculate the variance of the state
state(numframes-2,1) = var(state(:,1));
state(numframes-2,2) = var(state(:,2));
state(numframes-2,3) = var(state(:,3));
state(numframes-2,4) = var(state(:,4));

% delete the useless variables
clearvars prev temp next 

%% The matrices for further calculation
% The observation matrix
H = [1.00 0 0 0; 0 0 1.00 0; 0 0 0 0; 0 0 0 0];
% The transpose matrix of observation matrix H^t
H_t = H.'; 

% The state transform matrix
F = [1 delta_t 0 0;0 1 0 0;0 0 1 delta_t;0 0 0 1];
% The transpose matrix of state transform matrix F^t
F_t = F.';

% The initial state error matrix
variance_x = state(numframes-2,1);
variance_vx = state(numframes-2,2);
variance_y = state(numframes-2,3);
variance_vy = state(numframes-2,4);

S = [variance_x 0 0 0;
     0 variance_vx 0 0;
     0 0 variance_y 0;
     0 0 0 variance_vy];

% delete the useless variables
clearvars variance_x variance_vx variance_y variance_vy

%% Kalman Filter
for i = 1:numframes-3
    predict_state = F.*state(i,:);
    predict_coord = H.*predict_state;
    measured_coord = coordinate(i+2,:);
    S_ = F.*S.*F_t;
    K = S.*H_t.*inv(H.*S.*H_t);
    % actual_state(i,:) = predict_state + K.*(measured_coord - predict_coord);
    S = (eye(4)-K.*H).*S_;
end

% clear the useless variables
clearvars predict_state predict_coord measured_coord
clearvars F F_t H H_t S_