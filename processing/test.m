%% This programme is used for testing %%
clear;
clc;

i=1200;
nframes = 1495;

load('D:\research\final-year-project\data\preprocess\2.5_1_1.mat');

for i = 1:(nframes-1)
    if isempty(structure(i).centroid) == 0 % represent that there are variables
        x1 = structure(i).centroid(1).Centroid;
        if isempty(structure(i+1).centroid) == 0
            x2 = structure(i+1).centroid(1).Centroid;
            distance0 = 20;
            distance = pdist([x1;x2],'euclidean');
            if distance0 >=distance
                distance0 = distance;
            end
        end
    end  
end


