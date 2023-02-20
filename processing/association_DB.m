%% Distance-based Association
clear; clc;
% % load data in data folder
% cd ..
% currentfolder = pwd;
% cd processing\
% load([currentfolder,'\data\centroid_v2\2.5_1_1.mat']);
load("test\test.mat")
numframes = 1496; % the number of frames is 1495
[path] = Association(structure,numframes);

% %% Save the matrix into authorization file
% save('association\2.5_1_1.mat','coordinate')