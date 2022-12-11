%% The programme about state calculation %%
clear; clc;

load('C:\Users\30348\Documents\final-year-project\data\association\2.5_1_1.mat');
numframes = 1495; % the number of frames is 1495
delta_t = 0.2; % the frame rate is 5 frames/s, in hence the Δt = 0.2s
m = size(coordinate);
number = m(1)/3;

%% get the series of state about the vehicle
for i = 1:numframes-4
    for n = 1:number
        % read in the measurand
        prev(1) = coordinate(3*n-2,i); 
        prev(2) = coordinate(3*n-1,i); 
        temp(1) = coordinate(3*n-2,i+1);
        temp(2) = coordinate(3*n-1,i+1);
        next(1) = coordinate(3*n-2,i+2);
        next(2) = coordinate(3*n-1,i+2);
        % store the state of vehicles
        state(i,5*n-4) = temp(1); % coordinate x
        state(i,5*n-3) = temp(2); % coordinate y
        state(i,5*n-2) = (next(1)-prev(1))/delta_t; % velocity x
        state(i,5*n-1) = (next(2)-prev(2))/delta_t; % velocity y
        state(i,5*n)   = coordinate(3*n,i+1);
    end
end

%% Save the state matrix into state file
save('C:\Users\30348\Documents\final-year-project\data\state\2.5_1_1.mat','state')