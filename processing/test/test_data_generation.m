%% test data generation
clear;clc;
nframes = 1496;
for i = 1:nframes
    centroid(1,1) = 100 + i + (-0.5 + rand(1,1));
    centroid(1,2) = 100 + i + (-0.5 + rand(1,1));
    centroid(2,1) = 1000 + i + (-0.5 + rand(1,1));
    centroid(2,2) = 1000 + i + (-0.5 + rand(1,1));
    centroid(3,1) = 2000 - i + (-0.5 + rand(1,1));
    centroid(3,2) = 2000 - i + (-0.5 + rand(1,1));
    structure(i).centroid = centroid;
end

save('test\test.mat','structure')
