%% The programme about state calculation %%
clear; clc;

load('C:\Users\30348\Documents\final-year-project\data\authorization\2.5_1_1.mat');
numframes = 1495; % the number of frames is 1495
delta_t = 0.2; % the frame rate is 5 frames/s, in hence the Δt = 0.2s

%% get the series of state about the vehicle
for i = 1:numframes-4   
    % read in the measurand
    prev = coordinate(:,i); 
    temp = coordinate(:,i+1);
    next = coordinate(:,i+2);
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

%% Save the state matrix into state file
save('C:\Users\30348\Documents\final-year-project\data\state\2.5_1_1.mat','state')